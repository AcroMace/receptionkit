//
//  AppDelegate.swift
//  ReceptionKit
//
//  Created by Andy Cho on 2015-04-23.
//  Copyright (c) 2015 Andy Cho. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let conversationDelegate = ConversationDelegate()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // SupportKit Settings
        let skSettings = SKTSettings(appToken: Config.SupportKit.AppToken)
        skSettings.enableGestureHintOnFirstLaunch = false
        skSettings.enableAppWideGesture = false
        SupportKit.initWithSettings(skSettings)
        
        // Setup SupportKit
        SupportKit.conversation().delegate = conversationDelegate
        SupportKit.setUserFirstName(Config.Slack.Name, lastName: "")
        SKTUser.currentUser().email = Config.Slack.Email
        
        // App-wide styles
        UIApplication.sharedApplication().setStatusBarHidden(true, withAnimation: UIStatusBarAnimation.Slide)
        UINavigationBar.appearance().barTintColor = UIColor(hex: Config.Colour.NavigationBar)
        
        return true
    }

}

