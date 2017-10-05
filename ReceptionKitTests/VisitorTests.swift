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
        assertMessage(.unknownVisitorUnknownVisitee())
    }

    func testVisitorsNameUnknownButKnowVisitee() {
        tapVisitor()
        tapReturnKey()
        tapKnowName()
        enterVisiteeName()
        tester.acknowledgeSystemAlert()
        assertPleaseWaitMessageExists()
        assertMessage(.unknownVisitorKnownVisitee(visiteeName: VisitorTests.visiteeName))
    }

    func testVisitorsNameKnownButDontKnowVisitee() {
        tapVisitor()
        enterVisitorName()
        tapDontKnowName()
        assertPleaseWaitMessageExists()
        assertMessage(.knownVisitorUnknownVisitee(visitorName: VisitorTests.visitorName))
    }

    func testVisitorsNameKnownButVisteeNotInContacts() {
        tapVisitor()
        enterVisitorName()
        tapKnowName()
        enterVisiteeName()
        tester.acknowledgeSystemAlert()
        assertPleaseWaitMessageExists()
        assertMessage(.knownVisitorKnownVisitee(visitorName: VisitorTests.visitorName, visiteeName: VisitorTests.visiteeName))
    }
}

extension VisitorTests {

    // MARK: Helpers - Main page

    fileprivate func tapVisitor() {
        tester.tapView(withAccessibilityLabel:
            Text.visitor.accessibility())
    }

    // MARK: Helpers - Enter name

    fileprivate func enterVisitorName() {
        tester.enterText(
            VisitorTests.visitorName,
            intoViewWithAccessibilityLabel: VisitorAskNameViewController.nameTextFieldAccessibilityLabel)
        tapReturnKey()
    }

    fileprivate func enterVisiteeName() {
        tester.enterText(
            VisitorTests.visiteeName,
            intoViewWithAccessibilityLabel: VisitorSearchViewController.nameTextFieldAccessibilityLabel)
        tapReturnKey()
    }

    fileprivate func tapReturnKey() {
        tester.enterText(intoCurrentFirstResponder: "\n")
    }

    // MARK: Helpers - Know the name

    fileprivate func tapKnowName() {
        tester.tapView(withAccessibilityLabel: Text.iKnow.accessibility())
    }

    // MARK: Helpers - Don't know the name
    fileprivate func tapDontKnowName() {
        tester.tapView(withAccessibilityLabel: Text.iDontKnow.accessibility())
    }

    // MARK: Helpers - Type of delivery

    fileprivate func tapSignatureRequired() {
        tester.tapView(withAccessibilityLabel: Text.signature.accessibility())
    }

    fileprivate func tapLeftAtReception() {
        tester.tapView(withAccessibilityLabel: Text.leftAtReception.accessibility())
    }

    // MARK: Helpers - Successfully sent message

    /// Check that we see the please wait screen
    fileprivate func assertPleaseWaitMessageExists() {
        tester.waitForView(withAccessibilityLabel: Text.pleaseWait.accessibility())
        tester.waitForView(withAccessibilityLabel: Text.pleaseWaitMessage.accessibility())
    }

    /**
     Helper to check sent message

     - parameter sentMessage: The message that should have been sent
     */
    fileprivate func assertMessage(_ sentMessage: SlackMessage) {
        assertMessageSent(mockMessageSender, message: sentMessage)
    }
}
