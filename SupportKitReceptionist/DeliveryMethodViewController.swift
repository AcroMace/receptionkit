//
//  DeliveryMethodViewController.swift
//  SupportKitReceptionist
//
//  Created by Andy cho on 2015-04-23.
//  Copyright (c) 2015 Andy cho. All rights reserved.
//

import UIKit

class DeliveryMethodViewController: UIViewController {
    
    var deliveryCompany: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        title = deliveryCompany
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //
    // Delivery method buttons
    //
    
    @IBAction func signatureButtonTapped(sender: AnyObject) {
        segueWithMessage(makeDeliveryFromText() + " that requires a signature!")
    }
    
    @IBAction func leftReceptionButtonTapped(sender: AnyObject) {
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
