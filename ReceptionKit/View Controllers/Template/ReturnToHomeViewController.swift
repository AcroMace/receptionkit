//
//  ReturnToHomeViewController.swift
//  ReceptionKit
//
//  Created by Andy Cho on 2015-04-29.
//  Copyright (c) 2015 Andy Cho. All rights reserved.
//

import UIKit

class ReturnToHomeViewController: UIViewController, Themed, ReturnsToHome {

    var backToHomeTimer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        setTheme()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        backToHomeTimer = startTimer()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopTimer(timer: backToHomeTimer)
        backToHomeTimer = nil
    }

}
