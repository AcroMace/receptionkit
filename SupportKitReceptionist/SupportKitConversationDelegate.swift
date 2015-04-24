//
//  SupportKitConversationDelegate.swift
//  SupportKitReceptionist
//
//  Created by Andy cho on 2015-04-24.
//  Copyright (c) 2015 Andy cho. All rights reserved.
//

import Foundation
import UIKit

class ConversationDelegate: UIViewController, SKTConversationDelegate {
    func conversation(conversation: SKTConversation!, didReceiveMessages messages: [AnyObject]!) {
        let lastMessage: SKTMessage = messages.last! as! SKTMessage
        
        if (!lastMessage.isFromCurrentUser) {
            println(lastMessage.name)
            println(lastMessage.text)
            println(lastMessage.avatarUrl)
            
            let alert = UIAlertController(title: lastMessage.name, message: lastMessage.text, preferredStyle: UIAlertControllerStyle.Alert)
            let okay = UIAlertAction(title: "Okay!", style: UIAlertActionStyle.Default) { (alert) -> Void in }
            alert.addAction(okay)
        
            let window = UIApplication.sharedApplication().delegate!.window!
            window!.rootViewController?.presentViewController(alert, animated: true) { () -> Void in }
        }
    }
    
    func conversation(conversation: SKTConversation!, shouldShowForAction action: SKTAction) -> Bool {
        return false
    }
    
    func conversation(conversation: SKTConversation!, shouldShowInAppNotificationForMessage message: SKTMessage!) -> Bool {
        return false
    }
    
    func conversation(conversation: SKTConversation!, unreadCountDidChange unreadCount: UInt) {
        // Do nothing
    }
}
