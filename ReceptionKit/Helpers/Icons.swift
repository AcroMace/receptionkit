//
//  Icons.swift
//  ReceptionKit
//
//  Created by Andy Cho on 2016-05-01.
//  Copyright © 2016 Andy Cho. All rights reserved.
//

import Foundation

// Used to get icons from Font Awesome for buttons
class Icons {

    // The unicode in FontAwesome for the icons
    private static let IconUnicode = [
        "delivery": "\u{f0d1}",
        "signature": "\u{f044}",
        "left at reception": "\u{f187}",
        "visitor": "\u{f007}",
        "i know": "\u{f02d}",
        "i don't know": "\u{f059}"
    ]

    static func get(key: String) -> String {
        return IconUnicode[key]!
    }

}
