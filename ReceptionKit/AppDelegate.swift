//
//  AppDelegate.swift
//  ReceptionKit
//
//  Created by Andy Cho on 2015-04-23.
//  Copyright (c) 2015 Andy Cho. All rights reserved.
//

import UIKit

var messageSender: MessageSender!
var camera: Camera!

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    // swiftlint:disable weak_delegate
    let conversationDelegate = ConversationDelegate()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        // Smooch Settings
        let smoochSettings = SKTSettings(appId: Config.Smooch.AppID)
        Smooch.initWith(smoochSettings) { error, _ in
            guard error == nil else {
                print("Could not initialize Smooch")
                print(error as Any)
                return
            }
            // Setup Smooch
            Smooch.conversation()?.delegate = self.conversationDelegate
            Smooch.setUserFirstName(Config.Slack.Name, lastName: "")
            SKTUser.current()?.email = Config.Slack.Email
        }

        // App-wide styles
        UIApplication.shared.isStatusBarHidden = true
        UINavigationBar.appearance().barTintColor = UIColor(hex: Config.Colour.NavigationBar)

        // Create an instance of the Camera
        // Cannot create this as a declaration above since the camera will not start
        // recording in that case
        camera = Camera()

        // Used to send messages to Smooch
        messageSender = SmoochMessageSender()

        return true
    }

}

// Extensions for tests
extension AppDelegate {

    /**
     Reset the application before starting a test
     */
    func reset() {
        guard let rootVC = self.window?.rootViewController as? UINavigationController else {
            Logger.error("Could not get the root view controller")
            return
        }
        rootVC.popToRootViewController(animated: false)
    }

    /**
     Replace the message sender being used with the provided one
     Used to provide a mock message sender

     - parameter newMessageSender: The message sender to use
     */
    func replaceMessageSender(_ newMessageSender: MessageSender) {
        messageSender = newMessageSender
    }

}
