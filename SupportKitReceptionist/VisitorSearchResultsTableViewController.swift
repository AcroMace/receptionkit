//
//  VisitorSearchResultsTableViewController.swift
//  SupportKitReceptionist
//
//  Created by Andy cho on 2015-04-23.
//  Copyright (c) 2015 Andy cho. All rights reserved.
//

import UIKit

class VisitorSearchResultsTableViewController: UITableViewController {

    var searchQuery: String?
    var searchResults: [Contact]?
    var timer: NSTimer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        title = searchQuery
    }

    override func viewWillAppear(animated: Bool) {
        timer = NSTimer.scheduledTimerWithTimeInterval(Constants.TIMEOUT_SECONDS, target: self, selector: "unwindToHome:", userInfo: nil, repeats: false)
    }

    override func viewWillDisappear(animated: Bool) {
        timer?.invalidate()
        timer = nil
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
        let cell = tableView.dequeueReusableCellWithIdentifier("contactCell", forIndexPath: indexPath) as! ContactTableViewCell

        let contact = searchResults![indexPath.row]
        cell.contactNameLabel.text = contact.name
        cell.contactPhoneLabel.text = formatPhoneString(contact.phones)
        
        if (contact.picture != nil) {
            cell.contactImage.image = contact.picture
        } else {
            cell.contactImage.image = UIImage(named: "UnknownContact")
        }
        cell.contactImage.layer.cornerRadius = 42.0
        cell.contactImage.layer.masksToBounds = true
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let contact = searchResults![indexPath.row]
//        println(contact.phone)
    }
    
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
            if (formattedString != "") {
                formattedString += "\t\t"
            }
            formattedString += "Work: " + workPhone.number
        }
        for mobilePhone in mobilePhones {
            if (formattedString != "") {
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


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
    
    func unwindToHome(timer: NSTimer!) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }

}
