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

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        reset()
    }

    func testUPSDeliveryRequiresSignature() {
        tapDelivery()
        tapUPS()
        tapSignatureRequired()
        assertPleaseWaitMessageExists()
    }

    func testCanadaPostDeliveryDoesNotRequireSignature() {
        tapDelivery()
        tapCanadaPost()
        tapLeftAtReception()
        assertThankYouMessageExists()
    }

    func testOtherCompanyOption() {
        tapDelivery()
        tapOther()
        tapLeftAtReception()
        assertThankYouMessageExists()
    }

}

private extension DeliveryTests {

    // MARK: Helpers - Main page

    private func tapDelivery() {
        tester.tapViewWithAccessibilityLabel(Text.Delivery.accessibility())
    }

    // MARK: Helpers - Delivery companies

    private func tapUPS() {
        tester.tapViewWithAccessibilityLabel(DeliveryCompany.UPS.text())
    }

    private func tapCanadaPost() {
        tester.tapViewWithAccessibilityLabel(DeliveryCompany.CanadaPost.text())
    }

    private func tapOther() {
        tester.tapViewWithAccessibilityLabel(DeliveryCompany.Other.text())
    }

    // MARK: Helpers - Type of delivery

    private func tapSignatureRequired() {
        tester.tapViewWithAccessibilityLabel(Text.Signature.accessibility())
    }

    private func tapLeftAtReception() {
        tester.tapViewWithAccessibilityLabel(Text.LeftAtReception.accessibility())
    }

    // MARK: Helpers - Successfully sent message

    /// Check that we see the please wait screen
    private func assertPleaseWaitMessageExists() {
        tester.waitForViewWithAccessibilityLabel(Text.PleaseWait.accessibility())
        tester.waitForViewWithAccessibilityLabel(Text.PleaseWaitMessage.accessibility())
    }

    /// Check that we see the thank you screen
    private func assertThankYouMessageExists() {
        tester.waitForViewWithAccessibilityLabel(Text.ThankYou.accessibility())
        tester.waitForViewWithAccessibilityLabel(Text.NiceDay.accessibility())
    }
}
