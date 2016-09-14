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
    fileprivate var viewModel: VisitorSearchResultsViewModel?

    static let selectedContactSegue = "SelectedContact"

    func configure(_ viewModel: VisitorSearchResultsViewModel) {
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Overwrite the theme - table should be white
        view.backgroundColor = UIColor.white
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.searchResults?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> ContactTableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContactTableViewCell.reuseIdentifier, for: indexPath) as? ContactTableViewCell else {
            Logger.error("Could not dequeue contact cell in VisitorSearchResultsTableViewController")
            return ContactTableViewCell()
        }

        guard let searchResults = viewModel?.searchResults , (indexPath as NSIndexPath).row < searchResults.count else {
            Logger.error("Search results not specified in VisitorSearchResultsTableViewController")
            return ContactTableViewCell()
        }

        let contact = searchResults[(indexPath as NSIndexPath).row]
        cell.configure(contact)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // No search results
        guard let searchResults = viewModel?.searchResults , (indexPath as NSIndexPath).row < searchResults.count else {
            return
        }
        let contactName = searchResults[(indexPath as NSIndexPath).row].name

        // No visitor name
        guard let visitorName = viewModel?.visitorName , !visitorName.isEmpty else {
            messageSender.sendMessage(.unknownVisitorKnownVisitee(visiteeName: contactName))
            performSelectedContactSegue()
            return
        }

        messageSender.sendMessage(.knownVisitorKnownVisitee(visitorName: visitorName, visiteeName: contactName))
        performSelectedContactSegue()
    }

    fileprivate func performSelectedContactSegue() {
        performSegue(withIdentifier: VisitorSearchResultsTableViewController.selectedContactSegue, sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let waitingViewController = segue.destination as? WaitingViewController else {
            return
        }

        // Configure the view model
        let waitingViewModel = WaitingViewModel(shouldAskToWait: true)
        waitingViewController.configure(waitingViewModel)
    }
}
