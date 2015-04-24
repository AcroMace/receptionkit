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
    
    var isPresentingMessage = false
    
    func conversation(conversation: SKTConversation!, didReceiveMessages messages: [AnyObject]!) {
        let lastMessage: SKTMessage = messages.last! as! SKTMessage
        
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
    
    func conversation(conversation: SKTConversation!, shouldShowForAction action: SKTAction) -> Bool {
        return false
    }
    
    func conversation(conversation: SKTConversation!, shouldShowInAppNotificationForMessage message: SKTMessage!) -> Bool {
        return false
    }
    
    func conversation(conversation: SKTConversation!, unreadCountDidChange unreadCount: UInt) {
        // Do nothing
    }
    
    func getTopViewController() -> UIViewController {
        return UIApplication.sharedApplication().keyWindow!.rootViewController!
    }
}
