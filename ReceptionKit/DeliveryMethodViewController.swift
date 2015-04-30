//
//  DeliveryMethodViewController.swift
//  ReceptionKit
//
//  Created by Andy Cho on 2015-04-23.
//  Copyright (c) 2015 Andy Cho. All rights reserved.
//

import UIKit

class DeliveryMethodViewController: UIViewController {
    
    var deliveryCompany: String?
    var shouldAskToWait = true
    var timer: NSTimer?
    
    @IBOutlet weak var signatureButton: UIButton!
    @IBOutlet weak var leftReceptionButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        signatureButton.setTitle(Text.get("signature"), forState: UIControlState.Normal)
        leftReceptionButton.setTitle(Text.get("left at reception"), forState: UIControlState.Normal)
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: Text.get("back"), style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        timer = NSTimer.scheduledTimerWithTimeInterval(Constants.TIMEOUT_SECONDS, target: self, selector: "unwindToHome:", userInfo: nil, repeats: false)
    }
    
    override func viewWillDisappear(animated: Bool) {
        timer?.invalidate()
        timer = nil
    }


    //
    // Delivery method buttons
    //
    
    @IBAction func signatureButtonTapped(sender: AnyObject) {
        shouldAskToWait = true
        segueWithMessage(makeDeliveryFromText() + " that requires a signature!")
    }
    
    @IBAction func leftReceptionButtonTapped(sender: AnyObject) {
        shouldAskToWait = false
        segueWithMessage(makeDeliveryFromText() + " that has been left at the reception!")
    }
    
    // Exclude the "from" if the delivery company is unknown
    func makeDeliveryFromText() -> String {
        var messageText = "There is a delivery"
        if deliveryCompany != "Other" {
            messageText += " from " + deliveryCompany!
        }
        return messageText
    }
    
    // Segue to the thank you controller after sending a SupportKit message
    func segueWithMessage(message: String) {
        sendMessage(message)
        performSegueWithIdentifier("DeliveryMethodSelectedSegue", sender: self)
    }

    //
    // MARK: - Navigation
    //

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let waitingViewController = segue.destinationViewController as? WaitingViewController {
            waitingViewController.shouldAskToWait = shouldAskToWait
        }
    }
    
    func unwindToHome(timer: NSTimer!) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }

}
