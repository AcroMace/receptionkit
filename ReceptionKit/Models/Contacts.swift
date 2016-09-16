//
//  Contacts.swift
//  ReceptionKit
//
//  Created by Andy Cho on 2015-04-23.
//  Copyright (c) 2015 Andy Cho. All rights reserved.
//

import Foundation
import AddressBook

class ContactPhone {

    var type: String
    var number: String

    init(type: String, number: String) {
        self.type = type
        self.number = number
    }

    func isWorkPhone() -> Bool {
        return self.type == "_$!<Work>!$_"
    }

    func isMobilePhone() -> Bool {
        return self.type == "_$!<Mobile>!$_"
    }

}


class Contact {

    var name: String
    var phones: [ContactPhone]
    var picture: UIImage?

    init(name: String, phones: [ContactPhone], picture: UIImage?) {
        self.name = name
        self.phones = phones
        self.picture = picture
    }


    // Check to see if the user has granted the address book permission, ask for permission if not
    // Returns true if authorized, false if not
    static func isAuthorized() -> Bool {
        // Get the authorization if needed
        let authStatus = ABAddressBookGetAuthorizationStatus()
        if authStatus == .denied || authStatus == .restricted {
                print("No permission to access the contacts")
        } else if authStatus == .notDetermined {
            ABAddressBookRequestAccessWithCompletion(nil) { (granted: Bool, error: CFError?) in
                print("Successfully got permission for the contacts")
            }
        }

        // Need to refetch the status if it was updated
        return ABAddressBookGetAuthorizationStatus() == ABAuthorizationStatus.authorized
    }


    // Search for all contacts that match a name
    static func search(_ name: String) -> [Contact] {
        guard isAuthorized() else {
            return []
        }

        let addressBook: ABAddressBook = ABAddressBookCreateWithOptions(nil, nil).takeUnretainedValue()
        let query = name as CFString
        let people = ABAddressBookCopyPeopleWithName(addressBook, query).takeRetainedValue() as Array

        var contacts = [Contact]()
        for person: ABRecord in people {
            let contactName: String = ABRecordCopyCompositeName(person).takeRetainedValue() as String
            let contactPhoneNumbers = getPhoneNumbers(person, property: kABPersonPhoneProperty)

            var contactPicture: UIImage?
            if let contactPictureDataOptional = ABPersonCopyImageData(person) {
                let contactPictureData = contactPictureDataOptional.takeRetainedValue() as Data
                contactPicture = UIImage(data: contactPictureData)
            }

            contacts.append(Contact(name: contactName, phones: contactPhoneNumbers, picture: contactPicture))
        }

        return contacts
    }


    //
    // Private functions
    //

    // Get a property from a ABPerson, returns an array of Strings that matches the value
    private static func getPhoneNumbers(_ person: ABRecord, property: ABPropertyID) -> [ContactPhone] {
        let personProperty = ABRecordCopyValue(person, property).takeRetainedValue()
        guard let personPropertyValues = ABMultiValueCopyArrayOfAllValues(personProperty) else {
            return []
        }

        var propertyValues = [ContactPhone]()
        let properties = personPropertyValues.takeUnretainedValue() as NSArray
        for (index, property) in properties.enumerated() {
            let propertyLabel = ABMultiValueCopyLabelAtIndex(personProperty, index).takeRetainedValue() as String
            if let propertyValue = property as? String {
                let phone = ContactPhone(type: propertyLabel, number: propertyValue)
                propertyValues.append(phone)
            }
        }

        return propertyValues
    }

}
