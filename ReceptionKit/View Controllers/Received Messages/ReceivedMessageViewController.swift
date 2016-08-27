//
//  ReceivedMessageViewController.swift
//  ReceptionKit
//
//  Created by Andy Cho on 2015-04-24.
//  Copyright (c) 2015 Andy Cho. All rights reserved.
//

import UIKit

struct ReceivedMessageViewModel {
    let name: String
    let message: String
    let picture: String
}

class ReceivedMessageViewController: UIViewController {

    @IBOutlet weak var contactPicture: UIImageView!
    @IBOutlet weak var contactTitle: UILabel!
    @IBOutlet weak var contactMessage: UITextView!

    static let nibName = String(ReceivedMessageViewController)

    var viewModel: ReceivedMessageViewModel?

    func configure(viewModel: ReceivedMessageViewModel) {
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        modalPresentationStyle = UIModalPresentationStyle.FormSheet
        preferredContentSize = CGSize(width: 600.0, height: 500.0)

        // Set the text
        contactTitle.text = viewModel?.name.uppercaseString
        contactMessage.text = viewModel?.message

        // Set a default image
        contactPicture.image = UIImage(named: "UnknownContact")
        contactPicture.layer.cornerRadius = 75.0
        contactPicture.layer.masksToBounds = true

        // Load the image
        guard let picture = viewModel?.picture, URL = NSURL(string: picture) else { return }
        NSURLConnection.sendAsynchronousRequest(NSURLRequest(URL: URL), queue: NSOperationQueue.mainQueue()) { [weak self] (reponse, data, error) -> Void in
            guard let `data` = data else { return }
            self?.contactPicture.image = UIImage(data: data)
        }
    }

}
