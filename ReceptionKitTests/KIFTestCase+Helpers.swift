//
//  KIFTestCase+Helpers.swift
//  ReceptionKit
//
//  Created by Andy Cho on 2016-08-29.
//  Copyright © 2016 Andy Cho. All rights reserved.
//

import KIF
@testable import ReceptionKit

extension KIFTestCase {

    func reset() {
        guard let delegate = UIApplication.sharedApplication().delegate as? AppDelegate else {
            Logger.error("Could not get the app delegate")
            return
        }
        delegate.reset()
    }

}
