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
        contactPicture.image = UIImage(named: "UnknownContact")
        contactPicture.layer.cornerRadius = 75.0
        contactPicture.layer.masksToBounds = true

        // Load the image
        guard let picture = picture, URL = NSURL(string: picture) else {
            return
        }
        NSURLConnection.sendAsynchronousRequest(NSURLRequest(URL: URL), queue: NSOperationQueue.mainQueue()) { [weak self] (reponse, data, error) -> Void in
            if let data = data {
                self?.contactPicture.image = UIImage(data: data)
            }
        }
    }

}
