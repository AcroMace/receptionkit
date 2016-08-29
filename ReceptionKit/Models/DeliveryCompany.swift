//
//  DeliveryCompany.swift
//  ReceptionKit
//
//  Created by Andy Cho on 2016-08-29.
//  Copyright © 2016 Andy Cho. All rights reserved.
//

import UIKit

enum DeliveryCompany {
    case UPS
    case FedEx
    case CanadaPost
    case Other

    /**
     Used to get the text used in messages for the companies
     Method used instead of having a String enum since the other button's text is calculated

     - returns: The string to use in messages
     */
    func text() -> String {
        switch self {
        case .UPS:
            return "UPS"
        case .FedEx:
            return "FedEx"
        case .CanadaPost:
            return "Canada Post"
        case .Other:
            return Text.Other.get()
        }
    }
}
