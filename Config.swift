//
//  Config.swift
//  ReceptionKit
//
//  Created by Andy Cho on 2015-04-29.
//  Copyright (c) 2015 Andy cho. All rights reserved.
//

import Foundation

class Config {
    
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
