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

    func sendMessage(slackMessage: SlackMessage) {
        sendText(slackMessage)
        if let photo = camera.takePhoto() where Config.Photos.SendOnInteraction {
            sendImage(photo)
        }
    }

    func sendText(slackMessage: SlackMessage) {
        textSent.append(slackMessage)
    }

    func sendImage(image: UIImage) {
        imagesSent.append(image)
    }

    func reset() {
        textSent = [SlackMessage]()
        imagesSent = [UIImage]()
    }

}
