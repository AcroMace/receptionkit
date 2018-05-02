//
//  VisitorViewController.swift
//  ReceptionKit
//
//  Created by Andy Cho on 2015-04-24.
//  Copyright (c) 2015 Andy Cho. All rights reserved.
//

import UIKit

class VisitorViewController: ReturnToHomeViewController, StackViewOrientable {

    // Name of the visitor set by VisitorAskNameViewController
    var visitorName: String?

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var knowButton: UIButton!
    @IBOutlet weak var notKnowButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        knowButton.setAttributedTitle(ButtonFormatter.getAttributedString(icon: .iKnow, text: .iKnow), for: UIControlState())
        knowButton.accessibilityLabel = Text.iKnow.accessibility()
        knowButton.titleLabel?.textAlignment = NSTextAlignment.center
        knowButton.titleEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)

        notKnowButton.setAttributedTitle(ButtonFormatter.getAttributedString(icon: .iDontKnow, text: .iDontKnow), for: UIControlState())
        notKnowButton.accessibilityLabel = Text.iDontKnow.accessibility()
        notKnowButton.titleLabel?.textAlignment = NSTextAlignment.center
        notKnowButton.titleEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)

        setButtonVerticalAlignment(withDeviceDimensions: view.bounds.size)
    }

    // Reset the alignment of the text on rotation
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        setButtonVerticalAlignment(withDeviceDimensions: size)
    }

    // MARK: - Navigation

    // Should post message if the visitor does not know who they are looking for
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let waitingViewController = segue.destination as? WaitingViewController {
            // Configure the view model
            let waitingViewModel = WaitingViewModel(shouldAskToWait: true)
            waitingViewController.configure(waitingViewModel)

            // We don't know the name of the person who just checked in
            guard let visitorName = visitorName, !visitorName.isEmpty else {
                messageSender.send(message: .unknownVisitorUnknownVisitee())
                doorbell.play()
                return
            }

            // We know the visitor's name but they don't know the person they're looking for
            messageSender.send(message: .knownVisitorUnknownVisitee(visitorName: visitorName))
            doorbell.play()
        } else if let visitorSearchViewController = segue.destination as? VisitorSearchViewController {
            visitorSearchViewController.configure(VisitorSearchViewModel(visitorName: visitorName))
        }
    }

}
