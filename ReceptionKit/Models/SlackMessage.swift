//
//  SlackMessage.swift
//  ReceptionKit
//
//  Created by Andy Cho on 2016-08-30.
//  Copyright © 2016 Andy Cho. All rights reserved.
//

import UIKit

enum SlackMessage {
    case KnownVisitorKnownVisitee(visitorName: String, visiteeName: String)
    case KnownVisitorUnknownVisitee(visitorName: String)
    case UnknownVisitorKnownVisitee(visiteeName: String)
    case UnknownVisitorUnknownVisitee()
    case RequiresSignature(deliveryCompany: DeliveryCompany)
    case LeftAtReception(deliveryCompany: DeliveryCompany)

    func text() -> String {
        switch self {
        case .KnownVisitorKnownVisitee(let visitorName, let visiteeName):
            return "\(visitorName) is at the reception looking for \(visiteeName)!"
        case .KnownVisitorUnknownVisitee(let visitorName):
            return "\(visitorName) is at the reception!"
        case .UnknownVisitorKnownVisitee(let visiteeName):
            return "Someone is at the reception looking for \(visiteeName)!"
        case .UnknownVisitorUnknownVisitee:
            return "Someone is at the reception!"
        case .RequiresSignature(let deliveryCompany):
            return makeDeliveryFromText(deliveryCompany) + " that requires a signature!"
        case .LeftAtReception(let deliveryCompany):
            return makeDeliveryFromText(deliveryCompany) + " that has been left at the reception!"
        }
    }

    // Exclude the "from" if the delivery company is unknown
    private func makeDeliveryFromText(deliveryCompany: DeliveryCompany) -> String {
        var messageText = "There is a delivery"
        if deliveryCompany != .Other {
            messageText += " from " + deliveryCompany.text()
        }
        return messageText
    }
}
