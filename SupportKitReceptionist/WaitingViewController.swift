//
//  WaitingViewController.swift
//  SupportKitReceptionist
//
//  Created by Andy cho on 2015-04-23.
//  Copyright (c) 2015 Andy cho. All rights reserved.
//

import UIKit

class WaitingViewController: UIViewController {
    
    // Set to false if the message below thank you should ask the person to wait
    var shouldAskToWait = true

    @IBOutlet weak var thankYouLabel: UILabel!
    @IBOutlet weak var thankYouMessageText: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let timer = NSTimer.scheduledTimerWithTimeInterval(60.0, target: self, selector: "unwindToHome:", userInfo: nil, repeats: false)
    }
    
    override func viewWillAppear(animated: Bool) {
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    func unwindToHome(timer: NSTimer!) {
        performSegueWithIdentifier("UnwindToHome", sender: self)
    }

}
