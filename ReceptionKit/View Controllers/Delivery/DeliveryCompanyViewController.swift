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
        otherButton.setTitle(Text.other.get(), for: UIControlState())
        otherButton.accessibilityLabel = Text.other.accessibility()

        // Make sure that the button images are not skewed
        upsButton.imageView!.contentMode = UIViewContentMode.scaleAspectFit
        upsButton.accessibilityLabel = DeliveryCompany.ups.text()
        fedExButton.imageView!.contentMode = UIViewContentMode.scaleAspectFit
        fedExButton.accessibilityLabel = DeliveryCompany.fedEx.text()
        canadaPostButton.imageView!.contentMode = UIViewContentMode.scaleAspectFit
        canadaPostButton.accessibilityLabel = DeliveryCompany.canadaPost.text()
        otherButton.accessibilityLabel = DeliveryCompany.other.text()
    }


    //
    // Delivery company button taps
    //

    @IBAction func upsButtonTapped(_ sender: AnyObject) {
        deliveryCompany = .ups
        performSegue(withIdentifier: DeliveryCompanyViewController.deliverySelectedSegue, sender: self)
    }

    @IBAction func fedExButtonTapped(_ sender: AnyObject) {
        deliveryCompany = .fedEx
        performSegue(withIdentifier: DeliveryCompanyViewController.deliverySelectedSegue, sender: self)
    }

    @IBAction func canadaPostButtonTapped(_ sender: AnyObject) {
        deliveryCompany = .canadaPost
        performSegue(withIdentifier: DeliveryCompanyViewController.deliverySelectedSegue, sender: self)
    }

    @IBAction func otherButtonTapped(_ sender: AnyObject) {
        deliveryCompany = .other
        performSegue(withIdentifier: DeliveryCompanyViewController.deliverySelectedSegue, sender: self)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let deliveryMethodViewController = segue.destination as? DeliveryMethodViewController
        guard let deliveryVC = deliveryMethodViewController, let deliveryCompany = deliveryCompany else {
            return
        }
        deliveryVC.configure(DeliveryMethodViewModel(deliveryCompany: deliveryCompany))
    }

}
