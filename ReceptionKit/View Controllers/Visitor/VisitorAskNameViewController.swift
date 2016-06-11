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

    let visitorEnteredNameSegue = "VisitorEnteredNameSegue"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.nameTextField.delegate = self
        nameTextField.borderStyle = UITextBorderStyle.RoundedRect
        yourNameLabel.text = Text.get("your name")
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        // Not doing this in viewDidLoad() as that raises the keyboard before the segue
        nameTextField.becomeFirstResponder()
    }


    //
    // MARK: - UITextViewDelegate
    //

    // Segue to the VisitorViewController when the name is entered
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        performSegueWithIdentifier(visitorEnteredNameSegue, sender: self)
        return false
    }


    //
    // MARK: - Navigation
    //

    // Set the visitor's name before the segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        guard let visitorViewController = segue.destinationViewController as? VisitorViewController else {
            return
        }
        visitorViewController.visitorName = nameTextField.text
    }

}
