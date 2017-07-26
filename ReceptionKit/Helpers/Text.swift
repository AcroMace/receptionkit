//
//  Text.swift
//  ReceptionKit
//
//  Created by Andy Cho on 2015-04-23.
//  Copyright (c) 2015 Andy Cho. All rights reserved.
//

// swiftlint:disable cyclomatic_complexity

enum TextLanguage {
    case english
    case french
}

// This is a class used to toggle between English and French
// In-app language toggle is not a feature that is supported by default by Apple
enum Text {
    case languageToggle
    case delivery
    case signature
    case leftAtReception
    case visitor
    case iKnow
    case iDontKnow
    case lookingFor
    case wizardOfOz
    case noContactInfo
    case yourName
    case thankYou
    case pleaseWait
    case pleaseWaitMessage
    case niceDay
    case back
    case other

    // The language to use by default
    static var language: TextLanguage = .english

    private func english() -> String {
        switch self {
        case .languageToggle:
            return "français" // Show the button to switch to French if English
        case .delivery:
            return "delivery"
        case .signature:
            return "i need a signature"
        case .leftAtReception:
            return "i left a package at the reception"
        case .visitor:
            return "i'm a visitor"
        case .iKnow:
            return "i know the name of the person i am here to see"
        case .iDontKnow:
            return "i don't know"
        case .lookingFor:
            return "Who are you looking for?"
        case .wizardOfOz:
            return "The Wonderful Wizard of Oz"
        case .noContactInfo:
            return "no contact info"
        case .yourName:
            return "What is your name?"
        case .thankYou:
            return "thank you! :)"
        case .pleaseWait:
            return "please wait"
        case .pleaseWaitMessage:
            return "someone will be here shortly to meet you"
        case .niceDay:
            return "and have a nice day"
        case .back:
            return "Back"
        case .other:
            return "other"
        }
    }

    private func french() -> String {
        switch self {
        case .languageToggle:
            return "English" // Show the button to switch to English if French
        case .delivery:
            return "livraison"
        case .signature:
            return "j'ai besoin d' une signature"
        case .leftAtReception:
            return "j'ai laissé un paquet à la réception"
        case .visitor:
            return "visiteur"
        case .iKnow:
            return "je connais le nom de la personne que je viens voir"
        case .iDontKnow:
            return "je ne sais pas"
        case .lookingFor:
            return "Quel est le nom de la personne?"
        case .wizardOfOz:
            return "Le Magicien d'Oz"
        case .noContactInfo:
            return "pas d'info de contact"
        case .yourName:
            return "Quel est votre nom?"
        case .thankYou:
            return "merci! :)"
        case .pleaseWait:
            return "veuillez patienter"
        case .pleaseWaitMessage:
            return "quelqu'un sera avec vous sous peu"
        case .niceDay:
            return "et bonne journée"
        case .back:
            return "Retour"
        case .other:
            return "autre"
        }
    }

    /// Get text from a key word
    func get() -> String {
        switch Text.language {
        case .english:
            return self.english()
        case .french:
            return self.french()
        }
    }

    /// Switch between English and French
    static func swapLanguage() {
        switch language {
        case .english:
            language = .french
        case .french:
            language = .english
        }
    }

    /// Get the accessibility label
    func accessibility() -> String {
        switch self {
        case .languageToggle:
            return "Switch to \(get())"
        default:
            return english().replacingOccurrences(of: "\n", with: " ")
        }
    }
}
