//
//  ReturnToHomeViewController.swift
//  ReceptionKit
//
//  Created by Andy Cho on 2015-04-29.
//  Copyright (c) 2015 Andy Cho. All rights reserved.
//

import UIKit

class ReturnToHomeViewController: ThemedViewController {

    var backToHomeTimer: Timer?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Start a timer to return back to the first view
        backToHomeTimer = Timer.scheduledTimer(timeInterval: Config.General.Timeout, target: self, selector: #selector(ReturnToHomeViewController.unwindToHome(_:)), userInfo: nil, repeats: false)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // Delete the timer
        backToHomeTimer?.invalidate()
        backToHomeTimer = nil
    }

    // Navigate back to the first view
    func unwindToHome(_ timer: Timer!) {
        self.navigationController?.popToRootViewController(animated: true)
    }

}
