//
//  VisitorSearchResultsTableViewController.swift
//  ReceptionKit
//
//  Created by Andy Cho on 2015-04-23.
//  Copyright (c) 2015 Andy Cho. All rights reserved.
//

import UIKit

struct VisitorSearchResultsViewModel {
    var visitorName: String?
    var searchQuery: String?
    var searchResults: [Contact]?
}

class VisitorSearchResultsTableViewController: ReturnToHomeTableViewController {
    private var viewModel: VisitorSearchResultsViewModel?

    func configure(viewModel: VisitorSearchResultsViewModel) {
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Overwrite the theme - table should be white
        view.backgroundColor = UIColor.whiteColor()
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.searchResults?.count ?? 0
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> ContactTableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier(ContactTableViewCell.reuseIdentifier, forIndexPath: indexPath) as? ContactTableViewCell else {
            Logger.error("Could not dequeue contact cell in VisitorSearchResultsTableViewController")
            return ContactTableViewCell()
        }

        guard let searchResults = viewModel?.searchResults where indexPath.row < searchResults.count else {
            Logger.error("Search results not specified in VisitorSearchResultsTableViewController")
            return ContactTableViewCell()
        }

        let contact = searchResults[indexPath.row]
        cell.configure(contact)
        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // No search results
        guard let searchResults = viewModel?.searchResults where indexPath.row < searchResults.count else {
            return
        }
        let contactName = searchResults[indexPath.row].name

        // No visitor name
        guard let visitorName = viewModel?.visitorName where !visitorName.isEmpty else {
            sendMessage("Someone is at the reception looking for \(contactName)!")
            performSegueWithIdentifier("SelectedContact", sender: self)
            return
        }

        sendMessage("\(visitorName) is at the reception looking for \(contactName)!")
        performSegueWithIdentifier("SelectedContact", sender: self)
    }

}
