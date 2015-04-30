//
//  HomeViewController.swift
//  ReceptionKit
//
//  Created by Andy Cho on 2015-04-23.
//  Copyright (c) 2015 Andy Cho. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var languageButton: UIBarButtonItem!
    @IBOutlet weak var deliveryButton: UIButton!
    @IBOutlet weak var visitorButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.titleView = UIImageView(image: UIImage(named: "RadialpointLogo"))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func languageButtonTapped(sender: AnyObject) {
        if languageButton.title != "English" {
            languageButton.title = "English"
        } else {
            languageButton.title = "français"
        }
        Text.swapLanguage()
        
        // The text on this view has to be manually updated
        deliveryButton.setTitle(Text.get("delivery"), forState: UIControlState.Normal)
        visitorButton.setTitle(Text.get("visitor"), forState: UIControlState.Normal)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: Text.get("back"), style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
    }
    
    
    //
    // MARK: - Navigation
    //
    
    @IBAction func unwindToHome(unwindSegue: UIStoryboardSegue) {
        // Perhaps delete conversation when that becomes supported by SupportKit?
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
