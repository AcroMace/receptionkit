//
//  ButtonFormatter.swift
//  ReceptionKit
//
//  Created by Andy Cho on 2016-05-01.
//  Copyright © 2016 Andy Cho. All rights reserved.
//

import Foundation

// Creates attributed strings using a provided key for buttons
class ButtonFormatter {

    // Fonts used to display the buttons
    // If these are missing, the app should crash
    private static let IconFont = UIFont(name: "FontAwesome", size: 300.0)!
    private static let TextFont = UIFont(name: "Futura-Medium", size: 48.0)!

    static func getAttributedString(icon icon: Icons, text: Text) -> NSAttributedString {
        let attributedString = NSMutableAttributedString()

        // Center align the text
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .Center
        // Add the text
        attributedString.appendAttributedString(NSAttributedString(string: icon.unicode() + "\n",
            attributes: [NSFontAttributeName: IconFont]))
        attributedString.appendAttributedString(NSAttributedString(string: text.get(), attributes: [NSFontAttributeName: TextFont]))
        // Set the style
        attributedString.addAttributes([
            NSParagraphStyleAttributeName: paragraphStyle,
            NSForegroundColorAttributeName: UIColor.whiteColor()
            ], range: NSRange(location: 0, length: attributedString.length))

        return attributedString
    }

}
