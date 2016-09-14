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
    func conversation(_ conversation: SKTConversation!, didReceiveMessages messages: [AnyObject]!) {
        // May be a bug here where messages are ignored if the messages are batched
        // and multiple messages are sent at once
        guard let lastMessage = conversation.messages.last as? SKTMessage , !lastMessage.isFromCurrentUser else {
            return
        }

        if Config.Photos.EnableCommand && containsImageCommand(lastMessage.text), let photo = camera.takePhoto() {
            messageSender.sendImage(photo)
        } else {
            showReceivedMessage(lastMessage)
        }
    }

    // Present the message
    func presentMessageView(_ viewController: UIViewController) {
        getTopViewController().present(viewController, animated: true) { () -> Void in
            self.isPresentingMessage = true
        }
    }

    // Dismiss the message
    func dismissMessageView(_ timer: Timer!) {
        guard isPresentingMessage else { return }
        getTopViewController().dismiss(animated: true) { [weak self] in
            self?.isPresentingMessage = false
        }
    }

    // Don't show the default Smooch conversation
    func conversation(_ conversation: SKTConversation!, shouldShowFor action: SKTAction) -> Bool {
        return false
    }

    // Don't show the default Smooch notification
    func conversation(_ conversation: SKTConversation!, shouldShowInAppNotificationFor message: SKTMessage!) -> Bool {
        return false
    }

    // Don't do anything when reading messages
    func conversation(_ conversation: SKTConversation!, unreadCountDidChange unreadCount: UInt) {
        // Do nothing
    }

    // MARK: - Private methods

    fileprivate func containsImageCommand(_ text: String) -> Bool {
        return text.contains(Config.Photos.ImageCaptureCommand)
    }

    fileprivate func showReceivedMessage(_ message: SKTMessage) {
        let topVC = getTopViewController()
        let receivedMessageView = createReceivedMessageView(message)

        // Check that there is no presentation already before presenting
        if isPresentingMessage {
            topVC.dismiss(animated: true) { () -> Void in
                self.isPresentingMessage = false
                self.presentMessageView(receivedMessageView)
            }
        } else {
            self.presentMessageView(receivedMessageView)
        }

        // Dismiss the message after 10 seconds
        Timer.scheduledTimer(
            timeInterval: 10.0,
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
    fileprivate func getTopViewController() -> UIViewController {
        return UIApplication.shared.keyWindow!.rootViewController!
    }

    /**
     Create a received message view

     - parameter lastMessage: Last message in the conversation

     - returns: The view created
     */
    fileprivate func createReceivedMessageView(_ lastMessage: SKTMessage) -> ReceivedMessageViewController {
        let receivedMessageView = ReceivedMessageViewController(nibName: ReceivedMessageViewController.nibName, bundle: nil)
        let receivedMessageViewModel = ReceivedMessageViewModel(
            name: lastMessage.name,
            message: lastMessage.text,
            picture: lastMessage.avatarUrl)
        receivedMessageView.configure(receivedMessageViewModel)
        return receivedMessageView
    }

}
