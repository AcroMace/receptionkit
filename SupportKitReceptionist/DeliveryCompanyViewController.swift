//
//  DeliveryCompanyViewController.swift
//  SupportKitReceptionist
//
//  Created by Andy cho on 2015-04-23.
//  Copyright (c) 2015 Andy cho. All rights reserved.
//

import UIKit

class DeliveryCompanyViewController: UIViewController {

    var deliveryCompany: String?
    let deliverySelectedSegue = "DeliveryCompanySelectedSegue"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Delivery"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //
    // Delivery company button taps
    //
    
    @IBAction func upsButtonTapped(sender: AnyObject) {
        deliveryCompany = "UPS"
        performSegueWithIdentifier(deliverySelectedSegue, sender: self)
    }
    
    @IBAction func fedExButtonTapped(sender: AnyObject) {
        deliveryCompany = "FedEx"
        performSegueWithIdentifier(deliverySelectedSegue, sender: self)
    }
    
    @IBAction func canadaPostButtonTapped(sender: AnyObject) {
        deliveryCompany = "Canada Post"
        performSegueWithIdentifier(deliverySelectedSegue, sender: self)
    }
    
    @IBAction func otherButtonTapped(sender: AnyObject) {
        deliveryCompany = "Other"
        performSegueWithIdentifier(deliverySelectedSegue, sender: self)
    }
    

    //
    // MARK: - Navigation
    //
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let deliveryMethodController = segue.destinationViewController as? DeliveryMethodViewController {
            deliveryMethodController.deliveryCompany = deliveryCompany
        }
    }

}
