//
//  VisitorViewController.swift
//  ReceptionKit
//
//  Created by Andy Cho on 2015-04-24.
//  Copyright (c) 2015 Andy Cho. All rights reserved.
//

import UIKit

class VisitorViewController: UIViewController {
    
    var timer: NSTimer?

    @IBOutlet weak var knowButton: UIButton!
    @IBOutlet weak var notKnowButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        knowButton.setTitle(Text.get("i know"), forState: UIControlState.Normal)
        notKnowButton.setTitle(Text.get("i don't know"), forState: UIControlState.Normal)
    }
    
    override func viewWillAppear(animated: Bool) {
        knowButton.titleLabel?.textAlignment = NSTextAlignment.Center
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: Text.get("back"), style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        timer = NSTimer.scheduledTimerWithTimeInterval(Config.General.Timeout, target: self, selector: "unwindToHome:", userInfo: nil, repeats: false)
    }
    
    override func viewWillDisappear(animated: Bool) {
        timer?.invalidate()
        timer = nil
    }
    
    func unwindToHome(timer: NSTimer!) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
}
