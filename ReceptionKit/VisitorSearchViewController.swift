//
//  VisitorSearchViewController.swift
//  ReceptionKit
//
//  Created by Andy Cho on 2015-04-23.
//  Copyright (c) 2015 Andy Cho. All rights reserved.
//

import UIKit

class VisitorSearchViewController: UIViewController, UITextFieldDelegate {

    var searchResults = [Contact]()
    var timer: NSTimer?
    
    @IBOutlet weak var lookingForLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        nameTextField.delegate = self
        nameTextField.borderStyle = UITextBorderStyle.RoundedRect
        nameTextField.placeholder = Text.get("wizard of oz")
        lookingForLabel.text = Text.get("looking for")
    }
    
    override func viewDidAppear(animated: Bool) {
        nameTextField.becomeFirstResponder()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: Text.get("back"), style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        timer = NSTimer.scheduledTimerWithTimeInterval(Constants.TIMEOUT_SECONDS, target: self, selector: "unwindToHome:", userInfo: nil, repeats: false)
    }
    
    override func viewWillDisappear(animated: Bool) {
        timer?.invalidate()
        timer = nil
    }

    
    //
    // MARK: - UITextFieldDelegate
    //
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        searchResults = Contact.search(nameTextField.text)

        if searchResults.count > 0 {
            performSegueWithIdentifier("VisitorNameSearchSegue", sender: self)
        } else {
            performSegueWithIdentifier("VisitorNameInvalidSearchSegue", sender: self)
        }
        
        return false
    }
    

    //
    // MARK: - Navigation
    //

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let visitorSearchResultsTableViewController = segue.destinationViewController as? VisitorSearchResultsTableViewController {
            visitorSearchResultsTableViewController.searchQuery = nameTextField.text
            visitorSearchResultsTableViewController.searchResults = searchResults
        }
    }
    
    func unwindToHome(timer: NSTimer!) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }

}