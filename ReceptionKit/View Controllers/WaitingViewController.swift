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
            thankYouLabel.text = Text.PleaseWait.get()
            thankYouMessageText.text = Text.PleaseWaitMessage.get()
        } else {
            thankYouLabel.text = Text.ThankYou.get()
            thankYouMessageText.text = Text.NiceDay.get()
        }
        thankYouMessageText.selectable = false
    }
}
