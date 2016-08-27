//
//  WaitingViewController.swift
//  ReceptionKit
//
//  Created by Andy Cho on 2015-04-23.
//  Copyright (c) 2015 Andy Cho. All rights reserved.
//

import UIKit

struct WaitingViewModel {
    // Set to false if the message below thank you should ask the person to wait
    var shouldAskToWait: Bool
}

class WaitingViewController: ReturnToHomeViewController {
    var viewModel: WaitingViewModel?

    @IBOutlet weak var thankYouLabel: UILabel!
    @IBOutlet weak var thankYouMessageText: UITextView!

    func configure(viewModel: WaitingViewModel) {
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let `viewModel` = viewModel else { return }

        thankYouMessageText.selectable = true
        if viewModel.shouldAskToWait {
            thankYouLabel.text = Text.get("please wait")
            thankYouMessageText.text = Text.get("please wait message")
        } else {
            thankYouLabel.text = Text.get("thank you")
            thankYouMessageText.text = Text.get("nice day")
        }
        thankYouMessageText.selectable = false
    }
}
