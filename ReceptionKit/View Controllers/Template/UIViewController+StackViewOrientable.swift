//
//  UIViewController+StackViewOrientable.swift
//  ReceptionKit
//
//  Created by Andy Cho on 2016-10-01.
//  Copyright © 2016 Andy Cho. All rights reserved.
//

import UIKit

/**
 * Protocol for view controllers that have UIStackViews containing buttons
 * that needs to be aligned differently depending on the orientation
 */
protocol StackViewOrientable {

    weak var stackView: UIStackView! { get set }

}

extension StackViewOrientable where Self: UIViewController {

    // Change the direction of the stack view given the dimensions of the device
    func setButtonVerticalAlignment(withDeviceDimensions size: CGSize) {
        if size.width < size.height {
            stackView.axis = .vertical
        } else {
            stackView.axis = .horizontal
        }
    }

}
