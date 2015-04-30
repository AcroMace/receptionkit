//
//  SupportKitHelpers.swift
//  ReceptionKit
//
//  Created by Andy Cho on 2015-04-23.
//  Copyright (c) 2015 Andy Cho. All rights reserved.
//

// Send a message through SupportKit
func sendMessage(text: String) {
    let message = SKTMessage(text: text)
    SupportKit.conversation().sendMessage(message)
}
