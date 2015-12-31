//
//  Colour.swift
//  ReceptionKit
//
//  Created by Andy Cho on 2015-04-29.
//  Copyright (c) 2015 Andy Cho. All rights reserved.
//

extension UIColor {

    // From Rudolf Adamkovic
    convenience init(hex: Int) {
        let components = (
            R: CGFloat((hex >> 16) & 0xff) / 255,
            G: CGFloat((hex >> 08) & 0xff) / 255,
            B: CGFloat((hex >> 00) & 0xff) / 255
        )
        self.init(red: components.R, green: components.G, blue: components.B, alpha: 1)
    }

}
