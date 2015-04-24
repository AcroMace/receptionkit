//
//  ReceivedMessageViewController.swift
//  SupportKitReceptionist
//
//  Created by Andy cho on 2015-04-24.
//  Copyright (c) 2015 Andy cho. All rights reserved.
//

import UIKit

class ReceivedMessageViewController: UIViewController {

    @IBOutlet weak var contactPicture: UIImageView!
    @IBOutlet weak var contactTitle: UILabel!
    @IBOutlet weak var contactMessage: UITextView!
    
    var picture: String?
    var name: String?
    var message: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set the text
        contactTitle.text = name?.uppercaseString
        contactMessage.text = message
        
        // Load the image
        if (picture != nil) {
            NSURLConnection.sendAsynchronousRequest(NSURLRequest(URL: NSURL(string: picture!)!), queue: NSOperationQueue.mainQueue()) { (reponse, data, error) -> Void in
                self.contactPicture.image = UIImage(data: data)
                self.contactPicture.layer.cornerRadius = 75.0
                self.contactPicture.layer.masksToBounds = true
            }
        }
        
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
