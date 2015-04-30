//
//  Config.swift
//  ReceptionKit
//
//  Created by Andy Cho on 2015-04-29.
//  Copyright (c) 2015 Andy Cho. All rights reserved.
//

import Foundation

class Config {
    
    class General {
        // Change to false if the logo at the top should not show
        static let ShowLogo = true
        
        // Time in seconds for when to reset back to the main screen
        static let Timeout = 30.0
    }
    
    class Colour {
        // Colour of the navigation bar
        static let NavigationBar = 0xC10812
    }
    
    class SupportKit {
        // Replace the token with App Token you get from app.supportkit.io
        static let AppToken = "eurqdnoj2xjppgfbh51zs2v89"
    }
    
    class Slack {
        // Name of the receptionist that appears in Slack
        static let Name = "Receptionist"
        
        // If you want a profile picture for the receptionist in Slack,
        // set a Gravatar for an email and replace the following
        static let Email = "receptionist@example.com"
    }
    
}
