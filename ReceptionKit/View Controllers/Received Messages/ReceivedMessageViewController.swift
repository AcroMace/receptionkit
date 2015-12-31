//
//  ReceivedMessageViewController.swift
//  ReceptionKit
//
//  Created by Andy Cho on 2015-04-24.
//  Copyright (c) 2015 Andy Cho. All rights reserved.
//

import UIKit

class ReceivedMessageViewController: UIViewController {

    @IBOutlet weak var contactPicture: UIImageView!
    @IBOutlet weak var contactTitle: UILabel!
    @IBOutlet weak var contactMessage: UITextView!

    var picture: String?
    var name: String?
    var message: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set the text
        contactTitle.text = name?.uppercaseString
        contactMessage.text = message

        // Set a default image
        self.contactPicture.image = UIImage(named: "UnknownContact")
        self.contactPicture.layer.cornerRadius = 75.0
        self.contactPicture.layer.masksToBounds = true

        // Load the image
        if picture != nil {
            NSURLConnection.sendAsynchronousRequest(NSURLRequest(URL: NSURL(string: picture!)!), queue: NSOperationQueue.mainQueue()) { (reponse, data, error) -> Void in
                if let imageData = data {
                    self.contactPicture.image = UIImage(data: imageData)
                }
            }
        }
    }

}
