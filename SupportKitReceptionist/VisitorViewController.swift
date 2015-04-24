//
//  VisitorViewController.swift
//  SupportKitReceptionist
//
//  Created by Andy Cho on 2015-04-24.
//  Copyright (c) 2015 Andy cho. All rights reserved.
//

import UIKit

class VisitorViewController: UIViewController {

    @IBOutlet weak var knowButton: UIButton!
    @IBOutlet weak var notKnowButton: UIButton!

    override func viewWillAppear(animated: Bool) {
        knowButton.titleLabel?.textAlignment = NSTextAlignment.Center
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        knowButton.setTitle(Text.get("i know"), forState: UIControlState.Normal)
        notKnowButton.setTitle(Text.get("i don't know"), forState: UIControlState.Normal)
    }
}
