//
//  ReturnToHomeViewController.swift
//  ReceptionKit
//
//  Created by Andy Cho on 2015-04-29.
//  Copyright (c) 2015 Andy Cho. All rights reserved.
//

import UIKit

class ReturnToHomeViewController: ThemedViewController {

    var backToHomeTimer: NSTimer?

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
