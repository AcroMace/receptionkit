//
//  Text.swift
//  SupportKitReceptionist
//
//  Created by Andy cho on 2015-04-23.
//  Copyright (c) 2015 Andy cho. All rights reserved.
//

import Foundation

let TextEnglish = [
    "delivery": "delivery",
    "signature": "i need a signature",
    "left at reception": "i left a package at the reception",
    "visitor": "i'm a visitor",
    "i know": "i know the name\nof the person i am\nhere to see",
    "i don't know": "i don't know",
    "looking for": "who are you looking for?",
    "wizard of oz": "The Wonderful Wizard of Oz",
    "your name": "what is your name?",
    "thank you": "thank you! :)",
    "nice day": "and have a nice day",
    "please wait": "someone will be here shortly to meet you",
    "other": "other"
]

let TextFrench = [
    "delivery": "livraison",
    "signature": "j'ai besoin d' une signature",
    "left at reception": "j'ai laissé un paquet à la réception",
    "visitor": "visiteur",
    "i know": "je connais le nom\nde la personne que\nje suis ici pour voir",
    "i don't know": "je ne sais pas",
    "looking for": "qui cherches-tu?",
    "wizard of oz": "Le Magicien d'Oz",
    "your name": "comment vous appelez-vous?",
    "thank you": "merci! :)",
    "nice day": "et bonne journée",
    "please wait": "quelqu'un sera bientôt ici de vous rencontrer",
    "other": "autre"
]

// Apologies to whoever has to maintain this
class Text {
    static var language = "English"
    
    // Get text from a key word
    static func get(text: String) -> String {
        if (language == "English") {
            return TextEnglish[text]!
        } else {
            return TextFrench[text]!
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

