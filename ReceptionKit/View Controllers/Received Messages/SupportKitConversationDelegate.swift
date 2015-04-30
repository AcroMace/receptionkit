//
//  SupportKitConversationDelegate.swift
//  ReceptionKit
//
//  Created by Andy Cho on 2015-04-24.
//  Copyright (c) 2015 Andy Cho. All rights reserved.
//

import Foundation
import UIKit

class ConversationDelegate: NSObject, SKTConversationDelegate {
    
    var isPresentingMessage = false
    
    // Display the message modal when a message arrives
    // Only displays the last message
    func conversation(conversation: SKTConversation!, didReceiveMessages messages: [AnyObject]!) {
        // May be a bug here where messages are ignored if the messages are batched
        // and multiple messages are sent at once
        let lastMessage: SKTMessage = messages.last! as! SKTMessage
        
        // This method is also called when the user sends a message
        // (ex. when a delivery method is tapped)
        if (!lastMessage.isFromCurrentUser) {
            let topVC = getTopViewController()
            
            let receivedMessageView = ReceivedMessageViewController(nibName: "ReceivedMessageViewController", bundle: nil)
            receivedMessageView.name = lastMessage.name
            receivedMessageView.message = lastMessage.text
            receivedMessageView.picture = lastMessage.avatarUrl
            receivedMessageView.modalPresentationStyle = UIModalPresentationStyle.FormSheet
            receivedMessageView.preferredContentSize = CGSize(width: 600.0, height: 500.0)
            
            // Check that there is no presentation already before presenting
            if (isPresentingMessage) {
                topVC.dismissViewControllerAnimated(true) { () -> Void in
                    self.isPresentingMessage = false
                    self.presentMessageView(receivedMessageView)
                }
            } else {
                self.presentMessageView(receivedMessageView)
            }
            
            // Dismiss the message after 10 seconds
            let timer = NSTimer.scheduledTimerWithTimeInterval(10.0, target: self, selector: "dismissMessageView:", userInfo: nil, repeats: false)
        }
    }
    
    // Present the message
    func presentMessageView(viewController: UIViewController) {
        getTopViewController().presentViewController(viewController, animated: true) { () -> Void in
            self.isPresentingMessage = true
        }
    }
    
    // Dismiss the message
    func dismissMessageView(timer: NSTimer!) {
        if (isPresentingMessage) {
            getTopViewController().dismissViewControllerAnimated(true) { () -> Void in
                self.isPresentingMessage = false
            }
        }
    }
    
    // Don't show the default SupportKit conversation
    func conversation(conversation: SKTConversation!, shouldShowForAction action: SKTAction) -> Bool {
        return false
    }
    
    // Don't show the default SupportKit notification
    func conversation(conversation: SKTConversation!, shouldShowInAppNotificationForMessage message: SKTMessage!) -> Bool {
        return false
    }
    
    // Don't do anything when reading messages
    func conversation(conversation: SKTConversation!, unreadCountDidChange unreadCount: UInt) {
        // Do nothing
    }
    
    // Get the view controller that's currently being presented
    // This is where the notification will show
    func getTopViewController() -> UIViewController {
        return UIApplication.sharedApplication().keyWindow!.rootViewController!
    }
}
