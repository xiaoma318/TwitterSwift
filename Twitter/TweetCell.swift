//
//  TweetCell.swift
//  Twitter
//
//  Created by Cheng Ma on 9/29/14.
//  Copyright (c) 2014 Charlie. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {


    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var screename: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var dataFromNow: UILabel!
    @IBOutlet weak var detail: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImage.sizeToFit()
        screename.sizeToFit()
        username.sizeToFit()
        dataFromNow.sizeToFit()
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
