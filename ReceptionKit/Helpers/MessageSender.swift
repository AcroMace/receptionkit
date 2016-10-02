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
    func send(message: SlackMessage) // Text + Image
    func send(text: SlackMessage)
    func send(image: UIImage)
}

class SmoochMessageSender: MessageSender {
    /**
     Send a message through Smooch
     Also send an image if SendOnInteraction is enabled

     - parameter message: The text of the message to send
     */
    func send(message: SlackMessage) {
        send(text: message)
        if let photo = camera.takePhoto(), Config.Photos.SendOnInteraction {
            send(image: photo)
        }
    }

    /**
     Send a text message through Smooch

     - parameter text: The text of the message to send
     */
    func send(text: SlackMessage) {
        let message = SKTMessage(text: text.text())
        Smooch.conversation()?.sendMessage(message)
    }

    /**
     Send an image through Smooch

     - parameter image: The image to send
     */
    func send(image: UIImage) {
        Smooch.conversation()?.send(image, withProgress: nil, completion: nil)
    }
}
