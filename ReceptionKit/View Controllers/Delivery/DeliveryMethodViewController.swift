//
//  DeliveryMethodViewController.swift
//  ReceptionKit
//
//  Created by Andy Cho on 2015-04-23.
//  Copyright (c) 2015 Andy Cho. All rights reserved.
//

import UIKit

struct DeliveryMethodViewModel {
    var deliveryCompany: String?
    var shouldAskToWait = true

    init(deliveryCompany: String?) {
        self.deliveryCompany = deliveryCompany
    }
}

class DeliveryMethodViewController: ReturnToHomeViewController {
    var viewModel: DeliveryMethodViewModel?

    @IBOutlet weak var signatureButton: UIButton!
    @IBOutlet weak var leftReceptionButton: UIButton!

    func configure(viewModel: DeliveryMethodViewModel) {
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        signatureButton.setAttributedTitle(ButtonFormatter.getAttributedString(icon: .Signature, text: .Signature), forState: .Normal)
        leftReceptionButton.setAttributedTitle(ButtonFormatter.getAttributedString(icon: .LeftAtReception, text: .LeftAtReception), forState: .Normal)
    }

    // MARK: - Delivery method buttons

    @IBAction func signatureButtonTapped(sender: AnyObject) {
        viewModel?.shouldAskToWait = true
        segueWithMessage(makeDeliveryFromText() + " that requires a signature!")
    }

    @IBAction func leftReceptionButtonTapped(sender: AnyObject) {
        viewModel?.shouldAskToWait = false
        segueWithMessage(makeDeliveryFromText() + " that has been left at the reception!")
    }

    // Exclude the "from" if the delivery company is unknown
    func makeDeliveryFromText() -> String {
        var messageText = "There is a delivery"
        if let deliveryCompany = viewModel?.deliveryCompany where deliveryCompany != "Other" {
            messageText += " from " + deliveryCompany
        }
        return messageText
    }

    // Segue to the thank you controller after sending a Smooch message
    func segueWithMessage(message: String) {
        sendMessage(message)
        performSegueWithIdentifier("DeliveryMethodSelectedSegue", sender: self)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        guard let waitingViewController = segue.destinationViewController as? WaitingViewController else {
            return
        }
        waitingViewController.configure(WaitingViewModel(shouldAskToWait: viewModel?.shouldAskToWait ?? true))
    }

}
