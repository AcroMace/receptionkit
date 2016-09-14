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

    func configure(_ viewModel: WaitingViewModel) {
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let `viewModel` = viewModel else {
            Logger.error("View model was not set on WaitingViewController")
            return
        }

        thankYouMessageText.isSelectable = true
        if viewModel.shouldAskToWait {
            thankYouLabel.text = Text.pleaseWait.get()
            thankYouLabel.accessibilityLabel = Text.pleaseWait.accessibility()

            thankYouMessageText.text = Text.pleaseWaitMessage.get()
            thankYouMessageText.accessibilityLabel = Text.pleaseWaitMessage.accessibility()
        } else {
            thankYouLabel.text = Text.thankYou.get()
            thankYouLabel.accessibilityLabel = Text.thankYou.accessibility()

            thankYouMessageText.text = Text.niceDay.get()
            thankYouMessageText.accessibilityLabel = Text.niceDay.accessibility()
        }
        thankYouMessageText.isSelectable = false
    }
}
