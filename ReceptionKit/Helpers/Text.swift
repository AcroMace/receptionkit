//
//  Text.swift
//  ReceptionKit
//
//  Created by Andy Cho on 2015-04-23.
//  Copyright (c) 2015 Andy Cho. All rights reserved.
//

enum TextLanguage {
    case English
    case French
}

// This is a class used to toggle between English and French
// In-app language toggle is not a feature that is supported by default by Apple
enum Text {
    case Delivery
    case Signature
    case LeftAtReception
    case Visitor
    case IKnow
    case IDontKnow
    case LookingFor
    case WizardOfOz
    case NoContactInfo
    case YourName
    case ThankYou
    case PleaseWait
    case PleaseWaitMessage
    case NiceDay
    case Back
    case Other

    // The language to use by default
    static var language: TextLanguage = .English

    private func english() -> String {
        switch self {
        case .Delivery:
            return "delivery"
        case .Signature:
            return "i need a signature"
        case .LeftAtReception:
            return "i left a package at the reception"
        case .Visitor:
            return "i'm a visitor"
        case .IKnow:
            return "i know the name\nof the person i am\nhere to see"
        case .IDontKnow:
            return "i don't know"
        case .LookingFor:
            return "Who are you looking for?"
        case .WizardOfOz:
            return "The Wonderful Wizard of Oz"
        case .NoContactInfo:
            return "no contact info"
        case .YourName:
            return "What is your name?"
        case .ThankYou:
            return "thank you! :)"
        case .PleaseWait:
            return "please wait"
        case .PleaseWaitMessage:
            return "someone will be here shortly to meet you"
        case .NiceDay:
            return "and have a nice day"
        case .Back:
            return "Back"
        case .Other:
            return "other"
        }
    }

    private func french() -> String {
        switch self {
        case .Delivery:
            return "livraison"
        case .Signature:
            return "j'ai besoin d' une signature"
        case .LeftAtReception:
            return "j'ai laissé un paquet à la réception"
        case .Visitor:
            return "visiteur"
        case .IKnow:
            return "je connais le nom\nde la personne que\nje viens voir"
        case .IDontKnow:
            return "je ne sais pas"
        case .LookingFor:
            return "Quel est le nom de la personne?"
        case .WizardOfOz:
            return "Le Magicien d'Oz"
        case .NoContactInfo:
            return "pas d'info de contact"
        case .YourName:
            return "Quel est votre nom?"
        case .ThankYou:
            return "merci! :)"
        case .PleaseWait:
            return "veuillez patienter"
        case .PleaseWaitMessage:
            return "quelqu'un sera avec vous sous peu"
        case .NiceDay:
            return "et bonne journée"
        case .Back:
            return "Retour"
        case .Other:
            return "autre"
        }
    }

    // Get text from a key word
    func get() -> String {
        switch Text.language {
        case .English:
            return self.english()
        case .French:
            return self.french()
        }
    }

    // Switch between English and French
    static func swapLanguage() {
        switch language {
        case .English:
            language = .French
        case .French:
            language = .English
        }
    }

}
