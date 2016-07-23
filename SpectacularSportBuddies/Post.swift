//
//  Post.swift
//  SpectacularSportBuddies
//
//  Created by Adela Gao on 7/23/16.
//  Copyright © 2016 Adela Gao. All rights reserved.
//

import Foundation
import UIKit

class Post {
    var username = ""
    var timeRange = ""
    var location = ""
    var sportType = ""
    var postTime: NSDate
    
    init(username: String, timeRange: String, location: String, sportType: String, postTime: Double) {
        self.username = username
        self.timeRange = timeRange
        self.location = location
        self.sportType = sportType
        self.postTime = NSDate(timeIntervalSince1970: postTime)
    }
}