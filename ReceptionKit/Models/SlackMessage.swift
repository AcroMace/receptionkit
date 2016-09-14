//
//  SlackMessage.swift
//  ReceptionKit
//
//  Created by Andy Cho on 2016-08-30.
//  Copyright © 2016 Andy Cho. All rights reserved.
//

import UIKit

enum SlackMessage {
    case knownVisitorKnownVisitee(visitorName: String, visiteeName: String)
    case knownVisitorUnknownVisitee(visitorName: String)
    case unknownVisitorKnownVisitee(visiteeName: String)
    case unknownVisitorUnknownVisitee()
    case requiresSignature(deliveryCompany: DeliveryCompany)
    case leftAtReception(deliveryCompany: DeliveryCompany)

    func text() -> String {
        switch self {
        case .knownVisitorKnownVisitee(let visitorName, let visiteeName):
            return "\(visitorName) is at the reception looking for \(visiteeName)!"
        case .knownVisitorUnknownVisitee(let visitorName):
            return "\(visitorName) is at the reception!"
        case .unknownVisitorKnownVisitee(let visiteeName):
            return "Someone is at the reception looking for \(visiteeName)!"
        case .unknownVisitorUnknownVisitee:
            return "Someone is at the reception!"
        case .requiresSignature(let deliveryCompany):
            return makeDeliveryFromText(deliveryCompany) + " that requires a signature!"
        case .leftAtReception(let deliveryCompany):
            return makeDeliveryFromText(deliveryCompany) + " that has been left at the reception!"
        }
    }

    // Exclude the "from" if the delivery company is unknown
    fileprivate func makeDeliveryFromText(_ deliveryCompany: DeliveryCompany) -> String {
        var messageText = "There is a delivery"
        if deliveryCompany != .other {
            messageText += " from " + deliveryCompany.text()
        }
        return messageText
    }
}
