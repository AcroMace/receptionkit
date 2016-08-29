//
//  DeliveryCompanyViewController.swift
//  ReceptionKit
//
//  Created by Andy Cho on 2015-04-23.
//  Copyright (c) 2015 Andy Cho. All rights reserved.
//

import UIKit

class DeliveryCompanyViewController: ReturnToHomeViewController {

    var deliveryCompany: DeliveryCompany?
    static let deliverySelectedSegue = "DeliveryCompanySelectedSegue"

    @IBOutlet weak var upsButton: UIButton!
    @IBOutlet weak var fedExButton: UIButton!
    @IBOutlet weak var canadaPostButton: UIButton!
    @IBOutlet weak var otherButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set the language
        otherButton.setTitle(Text.Other.get(), forState: UIControlState.Normal)
        otherButton.accessibilityLabel = Text.Other.accessibility()

        // Make sure that the button images are not skewed
        upsButton.imageView!.contentMode = UIViewContentMode.ScaleAspectFit
        upsButton.accessibilityLabel = DeliveryCompany.UPS.text()
        fedExButton.imageView!.contentMode = UIViewContentMode.ScaleAspectFit
        fedExButton.accessibilityLabel = DeliveryCompany.FedEx.text()
        canadaPostButton.imageView!.contentMode = UIViewContentMode.ScaleAspectFit
        canadaPostButton.accessibilityLabel = DeliveryCompany.CanadaPost.text()
        otherButton.accessibilityLabel = DeliveryCompany.Other.text()
    }


    //
    // Delivery company button taps
    //

    @IBAction func upsButtonTapped(sender: AnyObject) {
        deliveryCompany = .UPS
        performSegueWithIdentifier(DeliveryCompanyViewController.deliverySelectedSegue, sender: self)
    }

    @IBAction func fedExButtonTapped(sender: AnyObject) {
        deliveryCompany = .FedEx
        performSegueWithIdentifier(DeliveryCompanyViewController.deliverySelectedSegue, sender: self)
    }

    @IBAction func canadaPostButtonTapped(sender: AnyObject) {
        deliveryCompany = .CanadaPost
        performSegueWithIdentifier(DeliveryCompanyViewController.deliverySelectedSegue, sender: self)
    }

    @IBAction func otherButtonTapped(sender: AnyObject) {
        deliveryCompany = .Other
        performSegueWithIdentifier(DeliveryCompanyViewController.deliverySelectedSegue, sender: self)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let deliveryMethodViewController = segue.destinationViewController as? DeliveryMethodViewController
        guard let deliveryVC = deliveryMethodViewController, deliveryCompany = deliveryCompany else {
            return
        }
        deliveryVC.configure(DeliveryMethodViewModel(deliveryCompany: deliveryCompany))
    }

}
