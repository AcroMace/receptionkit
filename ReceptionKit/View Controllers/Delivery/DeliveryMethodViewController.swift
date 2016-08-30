//
//  DeliveryMethodViewController.swift
//  ReceptionKit
//
//  Created by Andy Cho on 2015-04-23.
//  Copyright (c) 2015 Andy Cho. All rights reserved.
//

import UIKit

struct DeliveryMethodViewModel {
    var deliveryCompany: DeliveryCompany
    var shouldAskToWait = true

    init(deliveryCompany: DeliveryCompany) {
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
        signatureButton.accessibilityLabel = Text.Signature.accessibility()

        leftReceptionButton.setAttributedTitle(ButtonFormatter.getAttributedString(icon: .LeftAtReception, text: .LeftAtReception), forState: .Normal)
        leftReceptionButton.accessibilityLabel = Text.LeftAtReception.accessibility()
    }

    // MARK: - Delivery method buttons

    @IBAction func signatureButtonTapped(sender: AnyObject) {
        guard let deliveryCompany = viewModel?.deliveryCompany else {
            Logger.error("Tapped signature button without delivery company being set")
            return
        }
        viewModel?.shouldAskToWait = true
        segueWithMessage(.RequiresSignature(deliveryCompany: deliveryCompany))
    }

    @IBAction func leftReceptionButtonTapped(sender: AnyObject) {
        guard let deliveryCompany = viewModel?.deliveryCompany else {
            Logger.error("Tapped left at reception button without delivery company being set")
            return
        }
        viewModel?.shouldAskToWait = false
        segueWithMessage(.LeftAtReception(deliveryCompany: deliveryCompany))
    }

    // Segue to the thank you controller after sending a Smooch message
    func segueWithMessage(message: SlackMessage) {
        messageSender.sendMessage(message)
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
