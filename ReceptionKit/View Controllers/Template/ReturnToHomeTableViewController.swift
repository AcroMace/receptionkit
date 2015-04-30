//
//  ReturnToHomeTableViewController.swift
//  ReceptionKit
//
//  Created by Andy Cho on 2015-04-29.
//  Copyright (c) 2015 Andy Cho. All rights reserved.
//

import UIKit

// ThemedViewController + ReturnToHomeViewController for a UITableViewController
// There's probably a better way to do this - maybe recreate UITableViewController with a UIViewController?

class ReturnToHomeTableViewController: UITableViewController {

    var backToHomeTimer: NSTimer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set the background colour
        self.view.backgroundColor = UIColor(hex: Config.Colour.Background)
        
        // Set the back button
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: Text.get("back"), style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Start a timer to return back to the first view
        backToHomeTimer = NSTimer.scheduledTimerWithTimeInterval(Config.General.Timeout, target: self, selector: "unwindToHome:", userInfo: nil, repeats: false)
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Delete the timer
        backToHomeTimer?.invalidate()
        backToHomeTimer = nil
    }
    
    // Navigate back to the first view
    func unwindToHome(timer: NSTimer!) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
}
