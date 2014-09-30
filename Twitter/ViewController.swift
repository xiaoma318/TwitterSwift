//
//  ViewController.swift
//  Twitter
//
//  Created by Cheng Ma on 9/28/14.
//  Copyright (c) 2014 Charlie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onSignIn(sender: AnyObject) {
        TwitterClient.sharedInstance.loginWithCompletion(){
            (user:User?, error:NSError?) in
            if user != nil{
                self.performSegueWithIdentifier("loginSegue", sender: self)
            } else {
                
            }
        }
    }

}

