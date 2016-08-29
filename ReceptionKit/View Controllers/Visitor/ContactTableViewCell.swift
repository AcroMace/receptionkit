//
//  ContactTableViewCell.swift
//  ReceptionKit
//
//  Created by Andy Cho on 2015-04-23.
//  Copyright (c) 2015 Andy Cho. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {

    static let reuseIdentifier = String(ContactTableViewCell)

    @IBOutlet weak var contactImage: UIImageView!
    @IBOutlet weak var contactNameLabel: UILabel!
    @IBOutlet weak var contactPhoneLabel: UILabel!

    func configure(contact: Contact) {
        let name = contact.name
        contactNameLabel.text = name
        contactNameLabel.accessibilityLabel = name

        let phone = formatPhoneString(contact.phones)
        contactPhoneLabel.text = phone
        contactPhoneLabel.accessibilityLabel = phone

        if let picture = contact.picture {
            contactImage.image = picture
        } else {
            contactImage.image = UIImage(named: "UnknownContact")
        }
        contactImage.accessibilityLabel = "\(contact.name) Phone"
        contactImage.layer.cornerRadius = 42.0
        contactImage.layer.masksToBounds = true
    }

    // Take the phone numbers and create a descriptive string for it
    private func formatPhoneString(phones: [ContactPhone]) -> String {
        var workPhones = [String]()
        var mobilePhones = [String]()

        let separator = "\t\t"
        var formattedString = ""

        phones.forEach { phone in
            if phone.isWorkPhone() {
                workPhones.append(phone.number)
            } else if phone.isMobilePhone() {
                mobilePhones.append(phone.number)
            }
        }

        if !workPhones.isEmpty {
            formattedString += "Work: " + workPhones.joinWithSeparator(separator)
        }
        if !mobilePhones.isEmpty {
            formattedString += "Mobile: " + mobilePhones.joinWithSeparator(separator)
        }

        return formattedString.isEmpty ? "No contact info" : formattedString
    }

}
