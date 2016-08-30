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
        getAppDelegate().reset()
    }

    func getAppDelegate() -> AppDelegate {
        guard let delegate = UIApplication.sharedApplication().delegate as? AppDelegate else {
            Logger.error("Could not get the app delegate")
            return AppDelegate()
        }
        return delegate
    }

    func mockOutMessageSender() -> MockMessageSender {
        let mockMessageSender = MockMessageSender()
        getAppDelegate().replaceMessageSender(mockMessageSender)
        return mockMessageSender
    }

    func assertMessageSent(messageSender: MockMessageSender, message: SlackMessage) {
        if !messageSender.wasMessageSent(message) {
            XCTFail("Message: \(message.text()) was expected to be sent but was not")
        }
    }

}
