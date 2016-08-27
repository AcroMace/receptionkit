//
//  Icons.swift
//  ReceptionKit
//
//  Created by Andy Cho on 2016-05-01.
//  Copyright © 2016 Andy Cho. All rights reserved.
//

import Foundation

// Used to get icons from Font Awesome for buttons
enum Icons {
    case Delivery
    case Signature
    case LeftAtReception
    case Visitor
    case IKnow
    case IDontKnow

    // The unicode in FontAwesome for the icons
    func unicode() -> String {
        switch self {
        case .Delivery:
            return "\u{f0d1}"
        case .Signature:
            return "\u{f044}"
        case .LeftAtReception:
            return "\u{f187}"
        case .Visitor:
            return "\u{f007}"
        case .IKnow:
            return "\u{f02d}"
        case .IDontKnow:
            return "\u{f059}"
        }
    }
}
