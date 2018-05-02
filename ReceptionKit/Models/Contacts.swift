//
//  Contacts.swift
//  ReceptionKit
//
//  Created by Andy Cho on 2015-04-23.
//  Copyright (c) 2015 Andy Cho. All rights reserved.
//

import Foundation
import Contacts

// MARK: - Contact

struct Contact {

    // Used to keep track of contact permission
    static let contactStore = CNContactStore()

    let name: String
    let phones: [ContactPhone]
    let picture: UIImage?

    init(name: String, phones: [ContactPhone], picture: UIImage?) {
        self.name = name
        self.phones = phones
        self.picture = picture
    }

}

// MARK: - ContactPhone
// Describes a phone number for a contact with helper methods

enum PhoneType {
    case main
    case mobile
    case fax
    case pager
}

struct ContactPhone {

    let type: PhoneType
    let number: String

    fileprivate init(type: String, number: String) {
        self.type = ContactPhone.getPhoneType(for: type)
        self.number = number
    }

    private static func getPhoneType(for label: String) -> PhoneType {
        switch label {
        case CNLabelPhoneNumberiPhone, CNLabelPhoneNumberMobile:
            return .mobile
        case CNLabelPhoneNumberMain:
            return .main
        case CNLabelPhoneNumberHomeFax, CNLabelPhoneNumberWorkFax, CNLabelPhoneNumberOtherFax:
            return .fax
        case CNLabelPhoneNumberPager:
            return .pager
        default:
            return .mobile
        }
    }

}

extension Contact {

    // Search for all contacts that match a name
    static func search(_ name: String, completion: @escaping (([Contact]) -> Void)) {
        isAuthorized { authorized in
            if !authorized {
                completion([])
                return
            }

            let namePredicate = CNContact.predicateForContacts(matchingName: name)
            let keysToFetch: [CNKeyDescriptor] = [
                CNContactFormatter.descriptorForRequiredKeys(for: .fullName),
                CNContactPhoneNumbersKey as CNKeyDescriptor,
                CNContactImageDataAvailableKey as CNKeyDescriptor,
                CNContactImageDataKey as CNKeyDescriptor
            ]
            guard let queriedContacts = try? Contact.contactStore.unifiedContacts(matching: namePredicate, keysToFetch: keysToFetch) else {
                Logger.error("Could not query contacts with the name: \(name)")
                completion([])
                return
            }

            let contacts: [Contact] = queriedContacts.compactMap { queriedContact in
                let name = [queriedContact.givenName, queriedContact.familyName].joined(separator: " ")
                let phoneNumbers: [ContactPhone] = queriedContact.phoneNumbers.compactMap { phoneNumber in
                    guard let label = phoneNumber.label else {
                        return nil
                    }
                    let number = phoneNumber.value.stringValue
                    return ContactPhone(type: label, number: number)
                }
                var contactImage: UIImage?
                if queriedContact.imageDataAvailable,
                    let imageData = queriedContact.imageData,
                    let image = UIImage(data: imageData) {
                    contactImage = image
                }
                return Contact(name: name, phones: phoneNumbers, picture: contactImage)
            }

            completion(contacts)
        }
    }

    //
    // Private functions
    //

    // Check to see if the user has granted the address book permission, ask for permission if not
    // Calls completion with true if authorized, false if not
    static func isAuthorized(completion: @escaping (Bool) -> Void) {
        // Get the authorization if needed
        let authStatus = CNContactStore.authorizationStatus(for: .contacts)
        switch authStatus {
        case .denied, .restricted:
            Logger.error("No permission to access the contacts")
            completion(false)
        case .notDetermined:
            contactStore.requestAccess(for: .contacts) { granted, error in
                guard error == nil else {
                    Logger.error("Requesting contact access: \(error.debugDescription)")
                    completion(false)
                    return
                }
                if granted {
                    Logger.debug("Successfully received permission for contacts")
                    completion(true)
                    return
                } else {
                    Logger.error("User denied contacts permission")
                    completion(false)
                    return
                }
            }
        case .authorized:
            completion(true)
        }
    }

}
