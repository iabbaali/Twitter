//
//  TweetCell.swift
//  Twitter
//
//  Created by Iqra Abbaali on 11/1/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    
    var favorited:Bool = false
    var retweeted:Bool = false
    var tweetId:Int = -1
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setFavorite(_ isFavorited:Bool)
    {
        favorited = isFavorited
        if (favorited)
        {
            favButton.setImage(UIImage(named: "favor-icon"), for: UIControl.State.normal)
        }
        else
        {
            favButton.setImage(UIImage(named: "favor-icon-1"), for: UIControl.State.normal)
        }
    }
    
    func setRetweet(_ isRetweeted:Bool)
    {
        retweeted = isRetweeted
        if (retweeted)
        {
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            retweetButton.isEnabled = false
        }
        else
        {
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
            retweetButton.isEnabled = true

        }
    }
    
    @IBAction func favoriteTweet(_ sender: Any)
    {
        let toBeFavorited = !favorited
        if (toBeFavorited)
        {
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(true)
            }, failure: { (Error) in
                print("Favorite did not succeed \(Error)")
            })
        }
        else
        {
            TwitterAPICaller.client?.unfavoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(false)
            }, failure: { (Error) in
                print("Unfavorite did not succeed. \(Error)")
            })
        }
    }
    
    @IBAction func retweetTweet(_ sender: Any)
    {
        TwitterAPICaller.client?.retweetTweet(tweetId: tweetId, success: {
            self.setRetweet(true)
        }, failure: { (Error) in
            print("Error in retweeting \(Error)")
        })
    }
}
