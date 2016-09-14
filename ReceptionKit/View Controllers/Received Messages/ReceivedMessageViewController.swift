//
//  ReceivedMessageViewController.swift
//  ReceptionKit
//
//  Created by Andy Cho on 2015-04-24.
//  Copyright (c) 2015 Andy Cho. All rights reserved.
//

import UIKit
import SDWebImage

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
        modalPresentationStyle = UIModalPresentationStyle.FormSheet
        preferredContentSize = CGSize(width: 600.0, height: 500.0)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set the text
        let name = viewModel?.name.uppercaseString
        contactTitle.text = name
        contactTitle.accessibilityLabel = name

        let message = viewModel?.message
        contactMessage.text = message
        contactMessage.accessibilityLabel = message

        // Set a default image
        contactPicture.image = UIImage(named: "UnknownContact")
        contactPicture.layer.cornerRadius = 75.0
        contactPicture.layer.masksToBounds = true
        contactPicture.accessibilityLabel = "\(name) Picture"

        // Load the image
        guard let picture = viewModel?.picture, URL = NSURL(string: picture) else { return }
        contactPicture.sd_setImageWithURL(URL)
    }

}
