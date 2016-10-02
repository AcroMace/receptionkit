//
//  UIViewController+Themed.swift
//  ReceptionKit
//
//  Created by Andy Cho on 2016-10-01.
//  Copyright © 2016 Andy Cho. All rights reserved.
//

import UIKit

/// Protocol for UIViewControllers that set the background colour theme
protocol Themed {

}

extension Themed where Self: UIViewController {

    /// Set the configured theme
    func setTheme() {
        // Set the background colour
        view.backgroundColor = UIColor(hex: Config.Colour.Background)

        // Set the back button
        navigationItem.backBarButtonItem = UIBarButtonItem(title: Text.back.get(), style: .plain, target: nil, action: nil)
    }

}
