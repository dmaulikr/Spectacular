//
//  AppState.swift
//  SpectacularSportBuddies
//
//  Created by Adela Gao on 7/23/16.
//  Copyright © 2016 Adela Gao. All rights reserved.
//

import Foundation

class AppState: NSObject {
    static let sharedInstance = AppState()
    var loggedIn = false
}