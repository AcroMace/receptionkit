//
//  HomeViewController.swift
//  ReceptionKit
//
//  Created by Andy Cho on 2015-04-23.
//  Copyright (c) 2015 Andy Cho. All rights reserved.
//

import UIKit

class HomeViewController: ThemedViewController {

    @IBOutlet weak var languageButton: UIBarButtonItem!
    @IBOutlet weak var deliveryButton: UIButton!
    @IBOutlet weak var visitorButton: UIButton!

    static let toggleEnglish = "English"
    static let toggleFrench = "français"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set the logo if ShowLogo is enabled
        if Config.General.ShowLogo {
            navigationItem.titleView = UIImageView(image: UIImage(named: "CompanyLogo"))
        }

        // Hide the language toggle if ShowLanguageToggle is disabled
        if !Config.General.ShowLanguageToggle {
            navigationItem.rightBarButtonItem = nil
        }

        updateButtons()
    }

    @IBAction func languageButtonTapped(sender: AnyObject) {
        Text.swapLanguage()
        languageButton.title = Text.LanguageToggle.get()
        languageButton.accessibilityLabel = Text.LanguageToggle.accessibility()

        // The text on this view has to be manually updated
        updateButtons()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: Text.Back.get(), style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
    }

    private func updateButtons() {
        deliveryButton.setAttributedTitle(ButtonFormatter.getAttributedString(icon: .Delivery, text: .Delivery), forState: .Normal)
        deliveryButton.accessibilityLabel = Text.Delivery.accessibility()

        visitorButton.setAttributedTitle(ButtonFormatter.getAttributedString(icon: .Visitor, text: .Visitor), forState: .Normal)
        visitorButton.accessibilityLabel = Text.Visitor.accessibility()
    }

}
