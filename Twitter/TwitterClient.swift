//
//  TwitterClient.swift
//  Twitter
//
//  Created by Cheng Ma on 9/28/14.
//  Copyright (c) 2014 Charlie. All rights reserved.
//

import UIKit

let key = "sK3wu9516MfRToyp2NhxCJBjK"
let secret = "aCvUUG89il4gjvWqanCXyjz4o1zP8Q18Mz3GN6NynMQm2GkiHj"
let url = NSURL(string:"https://api.twitter.com")

class TwitterClient: BDBOAuth1RequestOperationManager {
    var loginCompletion:((user: User?, error: NSError?) -> ())?
    class var sharedInstance:TwitterClient{
    struct Static{
        static let instance = TwitterClient(baseURL: url, consumerKey: key, consumerSecret: secret)
        }
        
        return Static.instance
    }
    
    func loginWithCompletion(completion: (user: User?, error: NSError?) -> ()){
        loginCompletion = completion
        
        requestSerializer.removeAccessToken()
        fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string:"xiaoma318://oauth"), scope: nil, success:  { (requestToken:BDBOAuthToken!) -> Void in
            println("success got the request token")
            var authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
            UIApplication.sharedApplication().openURL(authURL)
            
            }) { (error: NSError!) -> Void in
                println("error:\(error)")
                self.loginCompletion?(user:nil, error:error)
        }
        
    }
    
    func homeTimelineWithCompletion(params: NSDictionary?,completion:(tweets:[Tweet]?,error:NSError?) -> ()){
        TwitterClient.sharedInstance.GET("1.1/statuses/home_timeline.json", parameters: params, success: { (operation:AFHTTPRequestOperation!, response:AnyObject!) -> Void in
            // println("user: \(response)")
            var tweets = Tweet.tweetsWithArray(response as [NSDictionary])
            
            completion(tweets: tweets, error: nil)
            
            }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println("fail to get user")
            completion(tweets: nil, error: error)
        }
    }
    
    func openURL(url: NSURL){
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuthToken(queryString: url.query), success:
            { (accessToken: BDBOAuthToken!) -> Void in
                println("Got the access token")
                TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
                
                TwitterClient.sharedInstance.GET("1.1/account/verify_credentials.json", parameters: nil, success: { (operation:AFHTTPRequestOperation!, response:AnyObject!) -> Void in
                    // println("user: \(response)")
                    var user = User(dictionary: response as NSDictionary)
                    User.currentUser = user
                    println("user:\(user.name)")
                    self.loginCompletion?(user:user, error:nil)
                    }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                        println("fail to get user")
                        self.loginCompletion?(user:nil, error:error)
                }
                
                
                
            },failure: { (error: NSError!) -> Void in
                println(error)
                self.loginCompletion?(user:nil, error:error)
        })
    }
    
}
