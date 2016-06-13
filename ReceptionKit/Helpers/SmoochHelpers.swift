//
//  SmoochHelpers.swift
//  ReceptionKit
//
//  Created by Andy Cho on 2015-12-31.
//  Copyright © 2015 Andy Cho. All rights reserved.
//

/**
 Send a message through Smooch
 Also send an image if SendOnInteraction is enabled

 - parameter text: The text of the message to send
 */
func sendMessage(text: String) {
    sendText(text)
    if let photo = camera.takePhoto() where Config.Photos.SendOnInteraction {
        sendImage(photo)
    }
}

/**
 Send a text message through Smooch

 - parameter text: The text of the message to send
 */
func sendText(text: String) {
    let message = SKTMessage(text: text)
    Smooch.conversation().sendMessage(message)
}

/**
 Send an image through Smooch

 - parameter image: The image to send
 */
func sendImage(image: UIImage) {
    Smooch.conversation().sendImage(image, withProgress: nil, completion: nil)
}
