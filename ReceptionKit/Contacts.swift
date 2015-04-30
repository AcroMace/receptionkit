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
        if (authStatus == ABAuthorizationStatus.Denied ||
            authStatus == ABAuthorizationStatus.Restricted) {
                println("No permission to access the contacts")
        } else if (authStatus == ABAuthorizationStatus.NotDetermined) {
            ABAddressBookRequestAccessWithCompletion(nil) { (granted: Bool, error: CFError!) in
                println("Successfully got permission for the contacts")
            }
        }
        
        // Need to refetch the status if it was updated
        return ABAddressBookGetAuthorizationStatus() == ABAuthorizationStatus.Authorized
    }
    
    
    // Search for all contacts that match a name
    static func search(name: String) -> [Contact] {
        var contacts = [Contact]()
        
        if (isAuthorized()) {
            let addressBook: ABAddressBook = ABAddressBookCreateWithOptions(nil, nil).takeUnretainedValue()
            let query = name as CFString
            let people = ABAddressBookCopyPeopleWithName(addressBook, query).takeRetainedValue() as Array
            
            
            
            for person:ABRecordRef in people {
                let contactName: String = ABRecordCopyCompositeName(person).takeRetainedValue() as String
                var contactPhoneNumbers = getPhoneNumbers(person, property: kABPersonPhoneProperty)
                
                let contactPictureDataOptional = ABPersonCopyImageData(person)
                var contactPicture: UIImage?
                if (contactPictureDataOptional != nil) {
                    let contactPictureData = ABPersonCopyImageData(person).takeRetainedValue() as NSData
                    contactPicture = UIImage(data: contactPictureData)
                }
                
                contacts.append(Contact(name: contactName, phones: contactPhoneNumbers, picture: contactPicture))
            }
        }

        // Will return an empty array if not authorized
        return contacts
    }
    
    
    //
    // Private functions
    //
    
    // Get a property from a ABPerson, returns an array of Strings that matches the value
    static func getPhoneNumbers(person: ABRecordRef, property: ABPropertyID) -> [ContactPhone] {
        var propertyValues = [ContactPhone]()
        
        let personProperty: ABMultiValueRef = ABRecordCopyValue(person, property).takeRetainedValue() as ABMultiValueRef
        let personPropertyValues = ABMultiValueCopyArrayOfAllValues(personProperty) // Returns nil if empty

        if (personPropertyValues != nil) {
            let properties = personPropertyValues.takeUnretainedValue() as NSArray
            for (index, property) in enumerate(properties) {
                let propertyLabel = ABMultiValueCopyLabelAtIndex(personProperty, index).takeRetainedValue() as String
                let propertyValue = property as! String
                let phone = ContactPhone(type: propertyLabel, number: propertyValue)
                propertyValues.append(phone)
            }
        }
        return propertyValues
    }
    
}

