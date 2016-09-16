//
//  VisitorSearchViewController.swift
//  ReceptionKit
//
//  Created by Andy Cho on 2015-04-23.
//  Copyright (c) 2015 Andy Cho. All rights reserved.
//

import UIKit

struct VisitorSearchViewModel {
    var visitorName: String?
    var searchResults = [Contact]()

    init(visitorName: String?) {
        self.visitorName = visitorName
    }
}

class VisitorSearchViewController: ReturnToHomeViewController, UITextFieldDelegate {
    private var viewModel: VisitorSearchViewModel?

    @IBOutlet weak var lookingForLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!

    static let lookingForLabelAccessibilityLabel = "Looking for label"
    static let nameTextFieldAccessibilityLabel = "Name text field"

    func configure(_ viewModel: VisitorSearchViewModel) {
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        lookingForLabel.text = Text.lookingFor.get()
        lookingForLabel.accessibilityLabel = VisitorSearchViewController.lookingForLabelAccessibilityLabel

        nameTextField.delegate = self
        nameTextField.borderStyle = UITextBorderStyle.roundedRect
        nameTextField.placeholder = Text.wizardOfOz.get()
        nameTextField.accessibilityLabel = VisitorSearchViewController.nameTextFieldAccessibilityLabel
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        nameTextField.becomeFirstResponder()
    }

    // MARK: - UITextFieldDelegate

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let nameText = nameTextField.text else {
            return false
        }

        viewModel?.searchResults = Contact.search(nameText)
        guard let numberOfSearchResults = viewModel?.searchResults.count else {
            return false
        }

        // Check if the person the visitor is searching for exists
        if numberOfSearchResults > 0 {
            performSegue(withIdentifier: "VisitorNameSearchSegue", sender: self)
        } else {
            performSegue(withIdentifier: "VisitorNameInvalidSearchSegue", sender: self)
        }

        return false
    }

    // MARK: - Navigation

    // Post a message if the person the visitor is looking for does not exist
    // Otherwise show the result of the search
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let visitorSearchResultsTableViewController = segue.destination as? VisitorSearchResultsTableViewController {
            // There is a result
            let searchResultsViewModel = VisitorSearchResultsViewModel(
                visitorName: viewModel?.visitorName,
                searchQuery: nameTextField.text,
                searchResults: viewModel?.searchResults)
            visitorSearchResultsTableViewController.configure(searchResultsViewModel)
        } else if let waitingViewController = segue.destination as? WaitingViewController {
            // Don't do anything if the visitor hasn't specified who they are looking for
            guard let lookingForName = nameTextField.text else { return }

            // Configure the view model
            let waitingViewModel = WaitingViewModel(shouldAskToWait: true)
            waitingViewController.configure(waitingViewModel)

            // The visitor's name is unknown
            guard let visitorName = viewModel?.visitorName, !visitorName.isEmpty else {
                messageSender.send(message: .unknownVisitorKnownVisitee(visiteeName: lookingForName))
                return
            }
            // The visitor's name is known
            messageSender.send(message: .knownVisitorKnownVisitee(visitorName: visitorName, visiteeName: lookingForName))
        }
    }

}
