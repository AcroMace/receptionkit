//
//  Text.swift
//  SupportKitReceptionist
//
//  Created by Andy cho on 2015-04-23.
//  Copyright (c) 2015 Andy cho. All rights reserved.
//

import Foundation

class TextEnglish {
    static func get(text: String) -> String {
        switch text {
        case "delivery":    return "delivery"
        case "thank you":   return "thank you! :)"
        case "nice day":    return "and have a nice day"
        case "please wait": return "someone will be here shortly to meet you"
        case "other":       return "other"
        default:            return "oopsie"
        }
    }
}

class TextFrench {
    static func get(text: String) -> String {
        switch text {
        case "delivery":    return "livraison"
        case "thank you":   return "merci! :)"
        case "nice day":    return "et bonne journée"
        case "please wait": return "quelqu'un sera bientôt ici de vous rencontrer"
        case "other":       return "autre"
        default:            return "uh oh"
        }
    }
}

// Apologies to whoever has to maintain this
class Text {
    static var language = "English"
    
    // Get text from a key word
    static func get(text: String) -> String {
        if (language == "English") {
            return TextEnglish.get(text)
        } else {
            return TextFrench.get(text)
        }
    }
    
    // Switch between English and French
    static func swapLanguage() {
        if (language == "English") {
            language = "French"
        } else {
            language = "English"
        }
    }
}

