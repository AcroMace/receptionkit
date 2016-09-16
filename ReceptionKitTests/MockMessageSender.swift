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

    func send(message: SlackMessage) {
        send(text: message)
        if let photo = camera.takePhoto(), Config.Photos.SendOnInteraction {
            send(image: photo)
        }
    }

    func send(text: SlackMessage) {
        textSent.append(text)
    }

    func send(image: UIImage) {
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
