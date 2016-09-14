//
//  DeliveryTests.swift
//  ReceptionKit
//
//  Created by Andy Cho on 2016-08-29.
//  Copyright © 2016 Andy Cho. All rights reserved.
//

import XCTest
import KIF
@testable import ReceptionKit

class DeliveryTests: KIFTestCase {

    var mockMessageSender = MockMessageSender()

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        reset()
        mockMessageSender = mockOutMessageSender()
    }

    func testUPSDeliveryRequiresSignature() {
        tapDelivery()
        tapUPS()
        tapSignatureRequired()
        assertPleaseWaitMessageExists()
        assertMessage(.requiresSignature(deliveryCompany: .ups))

    }

    func testCanadaPostDeliveryDoesNotRequireSignature() {
        tapDelivery()
        tapCanadaPost()
        tapLeftAtReception()
        assertThankYouMessageExists()
        assertMessage(.leftAtReception(deliveryCompany: .canadaPost))
    }

    func testOtherCompanyOption() {
        tapDelivery()
        tapOther()
        tapLeftAtReception()
        assertThankYouMessageExists()
        assertMessage(.leftAtReception(deliveryCompany: .other))
    }

}

private extension DeliveryTests {

    // MARK: Helpers - Main page

    func tapDelivery() {
        tester.tapView(withAccessibilityLabel: Text.delivery.accessibility())
    }

    // MARK: Helpers - Delivery companies

    func tapUPS() {
        tester.tapView(withAccessibilityLabel: DeliveryCompany.ups.text())
    }

    func tapCanadaPost() {
        tester.tapView(withAccessibilityLabel: DeliveryCompany.canadaPost.text())
    }

    func tapOther() {
        tester.tapView(withAccessibilityLabel: DeliveryCompany.other.text())
    }

    // MARK: Helpers - Type of delivery

    func tapSignatureRequired() {
        tester.tapView(withAccessibilityLabel: Text.signature.accessibility())
    }

    func tapLeftAtReception() {
        tester.tapView(withAccessibilityLabel: Text.leftAtReception.accessibility())
    }

    // MARK: Helpers - Successfully sent message

    /// Check that we see the please wait screen
    func assertPleaseWaitMessageExists() {
        tester.waitForView(withAccessibilityLabel: Text.pleaseWait.accessibility())
        tester.waitForView(withAccessibilityLabel: Text.pleaseWaitMessage.accessibility())
    }

    /// Check that we see the thank you screen
    func assertThankYouMessageExists() {
        tester.waitForView(withAccessibilityLabel: Text.thankYou.accessibility())
        tester.waitForView(withAccessibilityLabel: Text.niceDay.accessibility())
    }

    /**
     Helper to check sent message

     - parameter sentMessage: The message that should have been sent
     */
    func assertMessage(_ sentMessage: SlackMessage) {
        assertMessageSent(mockMessageSender, message: sentMessage)
    }
}
