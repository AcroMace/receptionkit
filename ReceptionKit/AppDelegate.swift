//
//  AppDelegate.swift
//  ReceptionKit
//
//  Created by Andy Cho on 2015-04-23.
//  Copyright (c) 2015 Andy Cho. All rights reserved.
//

import UIKit

var camera: Camera!

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let conversationDelegate = ConversationDelegate()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        // Smooch Settings
        let smoochSettings = SKTSettings(appToken: Config.Smooch.AppToken)
        Smooch.initWithSettings(smoochSettings)

        // Setup Smooch
        Smooch.conversation().delegate = conversationDelegate
        Smooch.setUserFirstName(Config.Slack.Name, lastName: "")
        SKTUser.currentUser().email = Config.Slack.Email

        // App-wide styles
        UIApplication.sharedApplication().setStatusBarHidden(true, withAnimation: UIStatusBarAnimation.Slide)
        UINavigationBar.appearance().barTintColor = UIColor(hex: Config.Colour.NavigationBar)

        // Create an instance of the Camera
        // Cannot create this as a declaration above since the camera will not start
        // recording in that case
        camera = Camera()

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
        rootVC.popToRootViewControllerAnimated(false)
    }

}
