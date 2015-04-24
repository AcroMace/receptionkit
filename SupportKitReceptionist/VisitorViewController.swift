//
//  VisitorViewController.swift
//  SupportKitReceptionist
//
//  Created by Andy Cho on 2015-04-24.
//  Copyright (c) 2015 Andy cho. All rights reserved.
//

import UIKit

class VisitorViewController: UIViewController {

    @IBOutlet weak var knowButton: UIButton!
    @IBOutlet weak var notKnowButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        knowButton.titleLabel?.textAlignment = NSTextAlignment.Center
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
