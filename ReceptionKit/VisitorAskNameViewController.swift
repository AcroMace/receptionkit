//
//  VisitorAskNameViewController.swift
//  ReceptionKit
//
//  Created by Andy Cho on 2015-04-23.
//  Copyright (c) 2015 Andy Cho. All rights reserved.
//

import UIKit

class VisitorAskNameViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var yourNameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!

    let visitorNameSetSegue = "VisitorNameSetSegue"
    var timer: NSTimer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.nameTextField.delegate = self
        nameTextField.borderStyle = UITextBorderStyle.RoundedRect
        yourNameLabel.text = Text.get("your name")
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: Text.get("back"), style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        timer = NSTimer.scheduledTimerWithTimeInterval(Constants.TIMEOUT_SECONDS, target: self, selector: "unwindToHome:", userInfo: nil, repeats: false)
    }
    
    override func viewDidAppear(animated: Bool) {
        // Not doing this in viewDidLoad() as that raises the keyboard before the segue
        nameTextField.becomeFirstResponder()
    }
    
    override func viewWillDisappear(animated: Bool) {
        timer?.invalidate()
        timer = nil
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
    
    func unwindToHome(timer: NSTimer!) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
}
