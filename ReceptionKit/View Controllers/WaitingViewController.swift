//
//  WaitingViewController.swift
//  ReceptionKit
//
//  Created by Andy Cho on 2015-04-23.
//  Copyright (c) 2015 Andy Cho. All rights reserved.
//

import UIKit

class WaitingViewController: ReturnToHomeViewController {
    
    // Set to false if the message below thank you should ask the person to wait
    var shouldAskToWait = true

    @IBOutlet weak var thankYouLabel: UILabel!
    @IBOutlet weak var thankYouMessageText: UITextView!

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        thankYouMessageText.selectable = true
        if (shouldAskToWait) {
            thankYouLabel.text = Text.get("please wait")
            thankYouMessageText.text = Text.get("please wait message")
        } else {
            thankYouLabel.text = Text.get("thank you")
            thankYouMessageText.text = Text.get("nice day")
        }
        thankYouMessageText.selectable = false
    }
    
}
