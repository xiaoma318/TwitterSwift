//
//  User.swift
//  Twitter
//
//  Created by Cheng Ma on 9/28/14.
//  Copyright (c) 2014 Charlie. All rights reserved.
//

import UIKit

var _currentUser : User?
let currentUserKey = "currentUserKey"
let userDidLoginNotification = "userDidLogin"
let userDidLogoutNotification = "userDidLogout"
class User: NSObject {
  
    
    var name:String?
    var screename:String?
    var profileImageUrl:String?
    var tagline:String?
    var dictionary:NSDictionary
    
    init(dictionary: NSDictionary){
        self.dictionary = dictionary
        name = dictionary["name"] as? String
        screename = dictionary["screen_name"]as? String
        profileImageUrl = dictionary["profile_image_url"]as? String
        tagline = dictionary["description"] as? String
    }
    
    func logout(){
        User.currentUser = nil
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        
        NSNotificationCenter.defaultCenter().postNotificationName(userDidLogoutNotification, object: nil)
    }
    
    class var currentUser: User? {
        get{
            if _currentUser == nil{
                var data = NSUserDefaults.standardUserDefaults().objectForKey(currentUserKey) as? NSData
                if data != nil{
                    var dictionary = NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: nil) as NSDictionary
                    _currentUser = User(dictionary: dictionary)
                }
            }
            return _currentUser
        }
        set(user){
            _currentUser = user
            
            if _currentUser != nil{
                var data = NSJSONSerialization.dataWithJSONObject(user!.dictionary, options: nil, error: nil)
                NSUserDefaults.standardUserDefaults().setObject(data, forKey: currentUserKey)
                
            } else{
                 NSUserDefaults.standardUserDefaults().setObject(nil, forKey: currentUserKey)
            }
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
}
