//
//  Contacts.swift
//  SupportKitReceptionist
//
//  Created by Andy cho on 2015-04-23.
//  Copyright (c) 2015 Andy cho. All rights reserved.
//

import Foundation
import AddressBook

class Contact {
    
    var name: String
    var email: [String]
    var phone: [String]
    var picture: UIImage?
    
    init(name: String, email: [String], phone: [String], picture: UIImage?) {
        self.name = name
        self.email = email
        self.phone = phone
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
                var contactEmails = getProperties(person, property: kABPersonEmailProperty)
                var contactPhoneNumbers = getProperties(person, property: kABPersonPhoneProperty)
                
                let contactPictureDataOptional = ABPersonCopyImageData(person)
                var contactPicture: UIImage?
                if (contactPictureDataOptional != nil) {
                    let contactPictureData = ABPersonCopyImageData(person).takeRetainedValue() as NSData
                    let contactPicture = UIImage(data: contactPictureData)
                }
                
                contacts.append(Contact(name: contactName, email: contactEmails, phone: contactPhoneNumbers, picture: contactPicture))
            }
        }

        // Will return an empty array if not authorized
        return contacts
    }
    
    
    //
    // Private functions
    //
    
    // Get a property from a ABPerson, returns an array of Strings that matches the value
    static func getProperties(person: ABRecordRef, property: ABPropertyID) -> [String] {
        var propertyValues = [String]()
        
        let personProperty: ABMultiValueRef = ABRecordCopyValue(person, property).takeRetainedValue() as ABMultiValueRef
        let personPropertyValues = ABMultiValueCopyArrayOfAllValues(personProperty) // Returns nil if empty

        if (personPropertyValues != nil) {
            let properties = personPropertyValues.takeUnretainedValue() as NSArray
            for property in properties {
                let propertyValue = property as! String
                propertyValues.append(propertyValue)
            }
        }
        return propertyValues
    }
    
}

