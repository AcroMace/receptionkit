//
//  MessageSender.swift
//  ReceptionKit
//
//  Created by Andy Cho on 2015-12-31.
//  Copyright © 2015 Andy Cho. All rights reserved.
//

/**
 *  Protocol used for a service that can send messages
 */
protocol MessageSender {
    func sendMessage(slackMessage: SlackMessage) // Text + Image
    func sendText(slackMessage: SlackMessage)
    func sendImage(image: UIImage)
}

class SmoochMessageSender: MessageSender {
    /**
     Send a message through Smooch
     Also send an image if SendOnInteraction is enabled

     - parameter text: The text of the message to send
     */
    func sendMessage(slackMessage: SlackMessage) {
        sendText(slackMessage)
        if let photo = camera.takePhoto() where Config.Photos.SendOnInteraction {
            sendImage(photo)
        }
    }

    /**
     Send a text message through Smooch

     - parameter text: The text of the message to send
     */
    func sendText(slackMessage: SlackMessage) {
        let message = SKTMessage(text: slackMessage.text())
        Smooch.conversation().sendMessage(message)
    }

    /**
     Send an image through Smooch

     - parameter image: The image to send
     */
    func sendImage(image: UIImage) {
        Smooch.conversation().sendImage(image, withProgress: nil, completion: nil)
    }
}
