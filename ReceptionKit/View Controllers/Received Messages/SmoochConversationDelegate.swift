//
//  SmoochConversationDelegate.swift
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
        guard let lastMessage = conversation.messages.last as? SKTMessage where !lastMessage.isFromCurrentUser else {
            return
        }

        if Config.Photos.EnableCommand && containsImageCommand(lastMessage.text), let photo = camera.takePhoto() {
            sendImage(photo)
        } else {
            showReceivedMessage(lastMessage)
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
        guard isPresentingMessage else { return }
        getTopViewController().dismissViewControllerAnimated(true) { [weak self] in
            self?.isPresentingMessage = false
        }
    }

    // Don't show the default Smooch conversation
    func conversation(conversation: SKTConversation!, shouldShowForAction action: SKTAction) -> Bool {
        return false
    }

    // Don't show the default Smooch notification
    func conversation(conversation: SKTConversation!, shouldShowInAppNotificationForMessage message: SKTMessage!) -> Bool {
        return false
    }

    // Don't do anything when reading messages
    func conversation(conversation: SKTConversation!, unreadCountDidChange unreadCount: UInt) {
        // Do nothing
    }

    // MARK: - Private methods

    private func containsImageCommand(text: String) -> Bool {
        return text.containsString(Config.Photos.ImageCaptureCommand)
    }

    private func showReceivedMessage(message: SKTMessage) {
        let topVC = getTopViewController()
        let receivedMessageView = createReceivedMessageView(message)

        // Check that there is no presentation already before presenting
        if isPresentingMessage {
            topVC.dismissViewControllerAnimated(true) { () -> Void in
                self.isPresentingMessage = false
                self.presentMessageView(receivedMessageView)
            }
        } else {
            self.presentMessageView(receivedMessageView)
        }

        // Dismiss the message after 10 seconds
        NSTimer.scheduledTimerWithTimeInterval(
            10.0,
            target: self,
            selector: #selector(ConversationDelegate.dismissMessageView(_:)),
            userInfo: nil,
            repeats: false)
    }

    /**
     Get the view controller that's currently being presented
     This is where the notification will show

     - returns: The top view controller
     */
    private func getTopViewController() -> UIViewController {
        return UIApplication.sharedApplication().keyWindow!.rootViewController!
    }

    /**
     Create a received message view

     - parameter lastMessage: Last message in the conversation

     - returns: The view created
     */
    private func createReceivedMessageView(lastMessage: SKTMessage) -> ReceivedMessageViewController {
        let receivedMessageView = ReceivedMessageViewController(nibName: ReceivedMessageViewController.nibName, bundle: nil)
        let receivedMessageViewModel = ReceivedMessageViewModel(
            name: lastMessage.name,
            message: lastMessage.text,
            picture: lastMessage.avatarUrl)
        receivedMessageView.configure(receivedMessageViewModel)
        return receivedMessageView
    }

}
