//
//  VisitorAskNameViewController.swift
//  ReceptionKit
//
//  Created by Andy Cho on 2015-04-23.
//  Copyright (c) 2015 Andy Cho. All rights reserved.
//

import UIKit

class VisitorAskNameViewController: ReturnToHomeViewController, UITextFieldDelegate {

    @IBOutlet weak var yourNameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!

    static let visitorEnteredNameSegue = "VisitorEnteredNameSegue"
    static let nameTextFieldAccessibilityLabel = "Name text field"
    static let yourNameLabelAccessibilityLabel = "Your name label"

    override func viewDidLoad() {
        super.viewDidLoad()

        nameTextField.delegate = self
        nameTextField.borderStyle = UITextBorderStyle.RoundedRect
        nameTextField.accessibilityLabel = VisitorAskNameViewController.nameTextFieldAccessibilityLabel
        yourNameLabel.text = VisitorAskNameViewController.nameTextFieldAccessibilityLabel
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        // Not doing this in viewDidLoad() as that raises the keyboard before the segue
        nameTextField.becomeFirstResponder()
    }

    // MARK: - UITextViewDelegate

    // Segue to the VisitorViewController when the name is entered
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        performSegueWithIdentifier(VisitorAskNameViewController.visitorEnteredNameSegue, sender: self)
        return false
    }

    // MARK: - Navigation

    // Set the visitor's name before the segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        guard let visitorViewController = segue.destinationViewController as? VisitorViewController else {
            return
        }
        visitorViewController.visitorName = nameTextField.text
    }

}
