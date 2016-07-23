//
//  PostTableViewCell.swift
//  SpectacularSportBuddies
//
//  Created by Adela Gao on 7/23/16.
//  Copyright © 2016 Adela Gao. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    var post: Post! {
        didSet {
            setupDisplay()
        }
    }
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var timeRangeLabel: UILabel!
    @IBOutlet weak var postedAtLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupDisplay() {
        nameLabel.text = post.username
        locationLabel.text = post.location
        timeRangeLabel.text = post.timeRange
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd' 'HH:mm"
        dateFormatter.timeZone = NSTimeZone.localTimeZone()
        postedAtLabel.text = dateFormatter.stringFromDate(post.postTime)
        // TODO: Fix word wrap
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
