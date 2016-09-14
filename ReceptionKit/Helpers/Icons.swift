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
    case delivery
    case signature
    case leftAtReception
    case visitor
    case iKnow
    case iDontKnow

    // The unicode in FontAwesome for the icons
    func unicode() -> String {
        switch self {
        case .delivery:
            return "\u{f0d1}"
        case .signature:
            return "\u{f044}"
        case .leftAtReception:
            return "\u{f187}"
        case .visitor:
            return "\u{f007}"
        case .iKnow:
            return "\u{f02d}"
        case .iDontKnow:
            return "\u{f059}"
        }
    }
}
