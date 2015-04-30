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

    let visitorNameSetSegue = "VisitorNameSetSegue"
    
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
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        let enteredName = nameTextField.text
        if enteredName == "" {
            sendMessage("Someone is at the reception!")
        } else {
            sendMessage(nameTextField.text + " is at the reception!")
        }
        performSegueWithIdentifier(visitorNameSetSegue, sender: self)
        return false
    }
    
}
