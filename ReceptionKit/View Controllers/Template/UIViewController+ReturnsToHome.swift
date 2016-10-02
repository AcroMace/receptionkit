//
//  UIViewController+ReturnsToHome.swift
//  ReceptionKit
//
//  Created by Andy Cho on 2016-10-01.
//  Copyright © 2016 Andy Cho. All rights reserved.
//

import UIKit

/// Protocol for UIViewControllers that return to the home view after a period of inactivity
protocol ReturnsToHome {
    var backToHomeTimer: Timer? { get set }
}

extension ReturnsToHome where Self: UIViewController {

    func startTimer() -> Timer {
        // Start a timer to return back to the first view
        return Timer.scheduledTimer(timeInterval: Config.General.Timeout, target: self, selector: #selector(UIViewController.returnToHomeScreen), userInfo: nil, repeats: false)
    }

    func stopTimer(timer: Timer?) {
        // Stop the timer
        timer?.invalidate()
    }

}

extension UIViewController {

    // Go back to the home screen, which is the root view controller
    func returnToHomeScreen() {
        _ = self.navigationController?.popToRootViewController(animated: true)
    }

}
