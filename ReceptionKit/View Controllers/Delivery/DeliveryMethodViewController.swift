//
//  DeliveryMethodViewController.swift
//  ReceptionKit
//
//  Created by Andy Cho on 2015-04-23.
//  Copyright (c) 2015 Andy Cho. All rights reserved.
//

import UIKit

class DeliveryMethodViewController: ReturnToHomeViewController {
    
    var deliveryCompany: String?
    var shouldAskToWait = true
    
    @IBOutlet weak var signatureButton: UIButton!
    @IBOutlet weak var leftReceptionButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        signatureButton.setTitle(Text.get("signature"), forState: UIControlState.Normal)
        leftReceptionButton.setTitle(Text.get("left at reception"), forState: UIControlState.Normal)
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
    
    // Segue to the thank you controller after sending a Smooch message
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

}
