//
//  OrientationNavigationController.swift
//  ReceptionKit
//
//  Created by Andy Cho on 2016-05-01.
//  Copyright © 2016 Andy Cho. All rights reserved.
//

import UIKit

class OrientationNavigationController: UINavigationController {

    // Ensure that the orientation change triggers an Auto Layout change on the iPad
    // Otherwise, the iPad dimensions are always Regular x Regular
    override func overrideTraitCollection(forChildViewController childViewController: UIViewController) -> UITraitCollection? {
        if view.bounds.width < view.bounds.height {
            return UITraitCollection(horizontalSizeClass: .compact)
        }
        return UITraitCollection(horizontalSizeClass: .regular)
    }

}
