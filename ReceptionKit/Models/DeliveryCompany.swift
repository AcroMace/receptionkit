//
//  DeliveryCompany.swift
//  ReceptionKit
//
//  Created by Andy Cho on 2016-08-29.
//  Copyright © 2016 Andy Cho. All rights reserved.
//

import UIKit

enum DeliveryCompany {
    case ups
    case fedEx
    case canadaPost
    case other

    /**
     Used to get the text used in messages for the companies
     Method used instead of having a String enum since the other button's text is calculated

     - returns: The string to use in messages
     */
    func text() -> String {
        switch self {
        case .ups:
            return "UPS"
        case .fedEx:
            return "FedEx"
        case .canadaPost:
            return "Canada Post"
        case .other:
            return Text.other.get()
        }
    }
}
