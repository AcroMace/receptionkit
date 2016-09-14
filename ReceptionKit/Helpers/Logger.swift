//
//  Logger.swift
//  ReceptionKit
//
//  Created by Andy Cho on 2016-08-03.
//  Copyright © 2016 Andy Cho. All rights reserved.
//

import UIKit

struct Logger {
    /**
     Print a debug message

     - parameter message: The message to print
     */
    static func debug(_ message: String) {
        print("DEBUG: \(message)")
    }

    /**
     Print an error message

     - parameter message: The message to print
     */
    static func error(_ message: String) {
        print("ERROR: \(message)")
    }
}
