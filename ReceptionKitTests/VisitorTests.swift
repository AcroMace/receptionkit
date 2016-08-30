//
//  VisitorTests.swift
//  ReceptionKit
//
//  Created by Andy Cho on 2016-08-29.
//  Copyright © 2016 Andy Cho. All rights reserved.
//

import XCTest
import KIF
@testable import ReceptionKit

class VisitorTests: KIFTestCase {

    static let visitorName = "Bob Bobberson"
    static let visiteeName = "Nancy Nannerson"

    var mockMessageSender = MockMessageSender()

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        reset()
        mockMessageSender = mockOutMessageSender()
    }

    func testVisitorsNameUnknownAndDontKnowVisitee() {
        tapVisitor()
        tapReturnKey()
        tapDontKnowName()
        assertPleaseWaitMessageExists()
    }

    func testVisitorsNameKnownButDontKnowVisitee() {
        tapVisitor()
        enterVisitorName()
        tapDontKnowName()
        assertPleaseWaitMessageExists()
    }

    func testVisitorsNameKnownButVisteeNotInContacts() {
        tapVisitor()
        enterVisitorName()
        tapKnowName()
        enterVisiteeName()
        assertPleaseWaitMessageExists()
    }
}

extension VisitorTests {

    // MARK: Helpers - Main page

    private func tapVisitor() {
        tester.tapViewWithAccessibilityLabel(Text.Visitor.accessibility())
    }

    // MARK: Helpers - Enter name

    private func enterVisitorName() {
        tester.enterText(
            VisitorTests.visitorName,
            intoViewWithAccessibilityLabel: VisitorAskNameViewController.nameTextFieldAccessibilityLabel)
        tapReturnKey()
    }

    private func enterVisiteeName() {
        tester.enterText(
            VisitorTests.visiteeName,
            intoViewWithAccessibilityLabel: VisitorSearchViewController.nameTextFieldAccessibilityLabel)
        tapReturnKey()
    }

    private func tapReturnKey() {
        tester.enterTextIntoCurrentFirstResponder("\n")
    }

    // MARK: Helpers - Know the name

    private func tapKnowName() {
        tester.tapViewWithAccessibilityLabel(Text.IKnow.accessibility())
    }

    // MARK: Helpers - Don't know the name
    private func tapDontKnowName() {
        tester.tapViewWithAccessibilityLabel(Text.IDontKnow.accessibility())
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

}
