//
//  SmoochHelpers.swift
//  ReceptionKit
//
//  Created by Andy Cho on 2015-12-31.
//  Copyright © 2015 Andy Cho. All rights reserved.
//

// Send a message through Smooch
func sendMessage(text: String) {
    let message = SKTMessage(text: text)
    Smooch.conversation().sendMessage(message)
}
