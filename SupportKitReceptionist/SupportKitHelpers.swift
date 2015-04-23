//
//  SupportKitHelpers.swift
//  SupportKitReceptionist
//
//  Created by Andy cho on 2015-04-23.
//  Copyright (c) 2015 Andy cho. All rights reserved.
//

import Foundation

func sendMessage(text: String) {
    let message = SKTMessage(text: text)
    SupportKit.conversation().sendMessage(message)
}
