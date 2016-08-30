//
//  VisitorViewController.swift
//  ReceptionKit
//
//  Created by Andy Cho on 2015-04-24.
//  Copyright (c) 2015 Andy Cho. All rights reserved.
//

import UIKit

class VisitorViewController: ReturnToHomeViewController {

    // Name of the visitor set by VisitorAskNameViewController
    var visitorName: String?

    @IBOutlet weak var knowButton: UIButton!
    @IBOutlet weak var notKnowButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        knowButton.setAttributedTitle(ButtonFormatter.getAttributedString(icon: .IKnow, text: .IKnow), forState: .Normal)
        knowButton.accessibilityLabel = Text.IKnow.accessibility()

        notKnowButton.setAttributedTitle(ButtonFormatter.getAttributedString(icon: .IDontKnow, text: .IDontKnow), forState: .Normal)
        notKnowButton.accessibilityLabel = Text.IDontKnow.accessibility()

        resetButtonVerticalAlignment(view.bounds.size)
    }

    // Centre align the button text - left-aligned by default
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        knowButton.titleLabel?.textAlignment = NSTextAlignment.Center
    }


    // Reset the alignment of the text on rotation
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        resetButtonVerticalAlignment(size)
    }

    func resetButtonVerticalAlignment(size: CGSize) {
        if size.width < size.height {
            // Vertical - alignment doesn't matter
            knowButton.contentVerticalAlignment = .Center
            notKnowButton.contentVerticalAlignment = .Center
        } else {
            // Horizontal - align to top
            knowButton.contentVerticalAlignment = .Top
            notKnowButton.contentVerticalAlignment = .Top
        }
    }

    // MARK: - Navigation

    // Should post message if the visitor does not know who they are looking for
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let waitingViewController = segue.destinationViewController as? WaitingViewController {
            // Configure the view model
            let waitingViewModel = WaitingViewModel(shouldAskToWait: true)
            waitingViewController.configure(waitingViewModel)

            // We don't know the name of the person who just checked in
            guard let visitorName = visitorName where !visitorName.isEmpty else {
                messageSender.sendMessage(.UnknownVisitorUnknownVisitee())
                return
            }

            // We know the visitor's name but they don't know the person they're looking for
            messageSender.sendMessage(.KnownVisitorUnknownVisitee(visitorName: visitorName))
        } else if let visitorSearchViewController = segue.destinationViewController as? VisitorSearchViewController {
            visitorSearchViewController.configure(VisitorSearchViewModel(visitorName: visitorName))
        }
    }

}
