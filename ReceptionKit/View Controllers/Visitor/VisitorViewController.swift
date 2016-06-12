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

        // Do any additional setup after loading the view.
        knowButton.setAttributedTitle(ButtonFormatter.getAttributedString("i know"), forState: .Normal)
        notKnowButton.setAttributedTitle(ButtonFormatter.getAttributedString("i don't know"), forState: .Normal)
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

    //
    // MARK: - Navigation
    //

    // Should post message if the visitor does not know who they are looking for
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let _ = segue.destinationViewController as? WaitingViewController {
            if visitorName == nil || visitorName == "" {
                sendMessage("Someone is at the reception!")
            } else {
                sendMessage("\(visitorName!) is at the reception!")
            }
        } else if let visitorSearchViewController = segue.destinationViewController as? VisitorSearchViewController {
            visitorSearchViewController.visitorName = visitorName
        }
    }

}
