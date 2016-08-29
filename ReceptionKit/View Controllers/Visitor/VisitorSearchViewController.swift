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

    func configure(viewModel: VisitorSearchViewModel) {
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        lookingForLabel.text = Text.LookingFor.get()
        lookingForLabel.accessibilityLabel = VisitorSearchViewController.lookingForLabelAccessibilityLabel

        nameTextField.delegate = self
        nameTextField.borderStyle = UITextBorderStyle.RoundedRect
        nameTextField.placeholder = Text.WizardOfOz.get()
        nameTextField.accessibilityLabel = VisitorSearchViewController.nameTextFieldAccessibilityLabel
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        nameTextField.becomeFirstResponder()
    }

    // MARK: - UITextFieldDelegate

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        guard let nameText = nameTextField.text else {
            return false
        }

        viewModel?.searchResults = Contact.search(nameText)

        // Check if the person the visitor is searching for exists
        if viewModel?.searchResults.count > 0 {
            performSegueWithIdentifier("VisitorNameSearchSegue", sender: self)
        } else {
            performSegueWithIdentifier("VisitorNameInvalidSearchSegue", sender: self)
        }

        return false
    }

    // MARK: - Navigation

    // Post a message if the person the visitor is looking for does not exist
    // Otherwise show the result of the search
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let visitorSearchResultsTableViewController = segue.destinationViewController as? VisitorSearchResultsTableViewController {
            // There is a result
            let searchResultsViewModel = VisitorSearchResultsViewModel(
                visitorName: viewModel?.visitorName,
                searchQuery: nameTextField.text,
                searchResults: viewModel?.searchResults)
            visitorSearchResultsTableViewController.configure(searchResultsViewModel)
        } else if segue.destinationViewController is WaitingViewController {
            // Don't do anything if the visitor hasn't specified who they are looking for
            guard let lookingForName = nameTextField.text else {
                return
            }
            // The visitor's name is unknown
            guard let visitorName = viewModel?.visitorName where !visitorName.isEmpty else {
                sendMessage("Someone is at the reception looking for \(lookingForName)!")
                return
            }
            // The visitor's name is known
            sendMessage("\(visitorName) is at the reception looking for \(lookingForName)!")
        }
    }

}
