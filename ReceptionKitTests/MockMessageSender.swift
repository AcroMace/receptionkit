//
//  MockMessageSender.swift
//  ReceptionKit
//
//  Created by Andy Cho on 2016-08-30.
//  Copyright © 2016 Andy Cho. All rights reserved.
//

import UIKit
@testable import ReceptionKit

class MockMessageSender: MessageSender {

    var textSent = [SlackMessage]()
    var imagesSent = [UIImage]()

    func sendMessage(_ slackMessage: SlackMessage) {
        sendText(slackMessage)
        if let photo = camera.takePhoto() , Config.Photos.SendOnInteraction {
            sendImage(photo)
        }
    }

    func sendText(_ slackMessage: SlackMessage) {
        textSent.append(slackMessage)
    }

    func sendImage(_ image: UIImage) {
        imagesSent.append(image)
    }

    func wasMessageSent(_ slackMessage: SlackMessage) -> Bool {
        let message = slackMessage.text()
        for sentText in textSent {
            if sentText.text() == message {
                return true
            }
        }
        return false
    }
}
