//
//  tweetViewController.swift
//  Twitter
//
//  Created by Cheng Ma on 9/29/14.
//  Copyright (c) 2014 Charlie. All rights reserved.
//

import UIKit

class tweetViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var tweets: [Tweet]?
    @IBOutlet weak var table: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        TwitterClient.sharedInstance.homeTimelineWithCompletion(nil, completion: { (tweets, error) -> () in
            self.tweets = tweets
            
            self.table.reloadData()
            
        })
        table.delegate = self
        table.dataSource = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func onLogout(sender: AnyObject) {
        User.currentUser?.logout()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
        
    {
        if tweets != nil {
            return tweets!.count
        }
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        var cell = tableView.dequeueReusableCellWithIdentifier("TweetCell") as TweetCell
        if tweets != nil{
            var tweet = tweets![indexPath.row]
            cell.profileImage.setImageWithURL(NSURL(string:tweet.user!.profileImageUrl!))
        
            cell.screename.text = tweet.user!.name
            cell.screename.sizeToFit()
            cell.username.text = "@"+tweet.user!.screename!
            cell.detail.text = tweet.text
            let currentDate = NSDate()
            var time = currentDate.timeIntervalSinceDate(tweet.createdAt!)
            var difference = Int(time/60/60)
            var timeUnit:String!
            if difference == 0{
                difference = Int(time/60)
                timeUnit = "min"
            }
            else{
                timeUnit = "h"
            }
            cell.dataFromNow.text = "\(difference.description)\(timeUnit)"
            
        }
        return cell
        
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
