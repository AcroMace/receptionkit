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
    
    init(name: String, email: [String]) {
        self.name = name
        self.email = email
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
                var contactEmails = [String]()
                
                // Get emails T_T
                let emailProperty: ABMultiValueRef = ABRecordCopyValue(person, kABPersonEmailProperty).takeRetainedValue() as ABMultiValueRef
                let emailPropertyValues = ABMultiValueCopyArrayOfAllValues(emailProperty) // Returns nil if empty
                if (emailPropertyValues != nil) {
                    let emailIds = emailPropertyValues.takeUnretainedValue() as NSArray
                    for emailId in emailIds {
                        let email = emailId as! String
                        contactEmails.append(email)
                    }
                }
                
                contacts.append(Contact(name: contactName, email: contactEmails))
            }
        }

        // Will return an empty array if not authorized
        return contacts
    }
    
}

