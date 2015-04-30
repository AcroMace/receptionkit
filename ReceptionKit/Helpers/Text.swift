//
//  Text.swift
//  ReceptionKit
//
//  Created by Andy Cho on 2015-04-23.
//  Copyright (c) 2015 Andy Cho. All rights reserved.
//

import Foundation

let TextEnglish = [
    "delivery": "delivery",
    "signature": "i need a signature",
    "left at reception": "i left a package at the reception",
    "visitor": "i'm a visitor",
    "i know": "i know the name\nof the person i am\nhere to see",
    "i don't know": "i don't know",
    "looking for": "Who are you looking for?",
    "wizard of oz": "The Wonderful Wizard of Oz",
    "no contact info": "no contact info",
    "your name": "What is your name?",
    "thank you": "thank you! :)",
    "please wait": "please wait",
    "nice day": "and have a nice day",
    "please wait message": "someone will be here shortly to meet you",
    "back": "Back",
    "other": "other"
]

let TextFrench = [
    "delivery": "livraison",
    "signature": "j'ai besoin d' une signature",
    "left at reception": "j'ai laissé un paquet à la réception",
    "visitor": "visiteur",
    "i know": "je connais le nom\nde la personne que\nje viens voir",
    "i don't know": "je ne sais pas",
    "looking for": "Quel est le nom de la personne?",
    "wizard of oz": "Le Magicien d'Oz",
    "no contact info": "pas d'info de contact",
    "your name": "Quel est votre nom?",
    "thank you": "merci! :)",
    "please wait": "veuillez patienter",
    "nice day": "et bonne journée",
    "please wait message": "quelqu'un sera avec vous sous peu",
    "back": "Retour",
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

