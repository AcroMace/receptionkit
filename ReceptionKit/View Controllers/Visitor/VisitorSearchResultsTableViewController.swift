//
//  VisitorSearchResultsTableViewController.swift
//  ReceptionKit
//
//  Created by Andy Cho on 2015-04-23.
//  Copyright (c) 2015 Andy Cho. All rights reserved.
//

import UIKit

class VisitorSearchResultsTableViewController: ReturnToHomeTableViewController {

    var visitorName: String?
    var searchQuery: String?
    var searchResults: [Contact]?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Overwrite the theme - table should be white
        self.view.backgroundColor = UIColor.whiteColor()
    }


    //
    // MARK: - Table view data source
    //

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults!.count ?? 0
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> ContactTableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier("contactCell", forIndexPath: indexPath) as? ContactTableViewCell else {
            print("ERROR: Could not dequeue contactCell in VisitorSearchResultsTableViewController")
            return ContactTableViewCell()
        }

        guard let searchResults = searchResults where indexPath.row < searchResults.count else {
            print("ERROR: Search results not specified in VisitorSearchResultsTableViewController")
            return ContactTableViewCell()
        }

        let contact = searchResults[indexPath.row]
        cell.contactNameLabel.text = contact.name
        cell.contactPhoneLabel.text = formatPhoneString(contact.phones)

        if let picture = contact.picture {
            cell.contactImage.image = picture
        } else {
            cell.contactImage.image = UIImage(named: "UnknownContact")
        }
        cell.contactImage.layer.cornerRadius = 42.0
        cell.contactImage.layer.masksToBounds = true

        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        guard let searchResults = searchResults where indexPath.row < searchResults.count else {
            return
        }

        let contact = searchResults[indexPath.row]
        if visitorName == nil || visitorName == "" {
            sendMessage("Someone is at the reception looking for \(contact.name)!")
        } else {
            sendMessage("\(visitorName!) is at the reception looking for \(contact.name)!")
        }
        performSegueWithIdentifier("SelectedContact", sender: self)
    }

    // Take the phone numbers and create a descriptive string for it
    func formatPhoneString(phones: [ContactPhone]) -> String {
        var workPhones = [ContactPhone]()
        var mobilePhones = [ContactPhone]()

        var formattedString = ""

        for phone in phones {
            if phone.isWorkPhone() == true {
                workPhones.append(phone)
            } else if phone.isMobilePhone() == true {
                mobilePhones.append(phone)
            }
        }

        for workPhone in workPhones {
            if formattedString != "" {
                formattedString += "\t\t"
            }
            formattedString += "Work: " + workPhone.number
        }
        for mobilePhone in mobilePhones {
            if formattedString != "" {
                formattedString += "\t\t"
            }
            formattedString += "Mobile: " + mobilePhone.number
        }

        if formattedString == "" {
            return "No contact info"
        } else {
            return formattedString
        }
    }

}
