//
//  VisitorViewController.swift
//  SupportKitReceptionist
//
//  Created by Andy Cho on 2015-04-24.
//  Copyright (c) 2015 Andy cho. All rights reserved.
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
        timer = NSTimer.scheduledTimerWithTimeInterval(Constants.TIMEOUT_SECONDS, target: self, selector: "unwindToHome:", userInfo: nil, repeats: false)
    }
    
    override func viewWillDisappear(animated: Bool) {
        timer?.invalidate()
        timer = nil
    }
    
    func unwindToHome(timer: NSTimer!) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
}
