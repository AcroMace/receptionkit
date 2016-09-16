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

    func configure(_ viewModel: DeliveryMethodViewModel) {
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        signatureButton.setAttributedTitle(ButtonFormatter.getAttributedString(icon: .signature, text: .signature), for: UIControlState())
        signatureButton.accessibilityLabel = Text.signature.accessibility()

        leftReceptionButton.setAttributedTitle(ButtonFormatter.getAttributedString(icon: .leftAtReception, text: .leftAtReception), for: UIControlState())
        leftReceptionButton.accessibilityLabel = Text.leftAtReception.accessibility()
    }

    // MARK: - Delivery method buttons

    @IBAction func signatureButtonTapped(_ sender: AnyObject) {
        guard let deliveryCompany = viewModel?.deliveryCompany else {
            Logger.error("Tapped signature button without delivery company being set")
            return
        }
        viewModel?.shouldAskToWait = true
        segueWithMessage(.requiresSignature(deliveryCompany: deliveryCompany))
    }

    @IBAction func leftReceptionButtonTapped(_ sender: AnyObject) {
        guard let deliveryCompany = viewModel?.deliveryCompany else {
            Logger.error("Tapped left at reception button without delivery company being set")
            return
        }
        viewModel?.shouldAskToWait = false
        segueWithMessage(.leftAtReception(deliveryCompany: deliveryCompany))
    }

    // Segue to the thank you controller after sending a Smooch message
    func segueWithMessage(_ message: SlackMessage) {
        messageSender.send(message: message)
        performSegue(withIdentifier: "DeliveryMethodSelectedSegue", sender: self)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        guard let waitingViewController = segue.destination as? WaitingViewController else {
            return
        }
        waitingViewController.configure(WaitingViewModel(shouldAskToWait: viewModel?.shouldAskToWait ?? true))
    }

}
