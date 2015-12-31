//
//  ThemedViewController.swift
//  ReceptionKit
//
//  Created by Andy Cho on 2015-04-29.
//  Copyright (c) 2015 Andy Cho. All rights reserved.
//

import UIKit

class ThemedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set the background colour
        self.view.backgroundColor = UIColor(hex: Config.Colour.Background)

        // Set the back button
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: Text.get("back"), style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
    }

}
