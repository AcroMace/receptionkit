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

    @IBAction func languageButtonTapped(_ sender: AnyObject) {
        Text.swapLanguage()
        languageButton.title = Text.languageToggle.get()
        languageButton.accessibilityLabel = Text.languageToggle.accessibility()

        // The text on this view has to be manually updated
        updateButtons()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: Text.back.get(), style: UIBarButtonItemStyle.plain, target: nil, action: nil)
    }

    private func updateButtons() {
        deliveryButton.setAttributedTitle(ButtonFormatter.getAttributedString(icon: .delivery, text: .delivery), for: UIControlState())
        deliveryButton.accessibilityLabel = Text.delivery.accessibility()

        visitorButton.setAttributedTitle(ButtonFormatter.getAttributedString(icon: .visitor, text: .visitor), for: UIControlState())
        visitorButton.accessibilityLabel = Text.visitor.accessibility()
    }

}
