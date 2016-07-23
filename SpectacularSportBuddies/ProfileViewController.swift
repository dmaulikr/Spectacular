//
//  ProfileViewController.swift
//  SpectacularSportBuddies
//
//  Created by Adela Gao on 7/23/16.
//  Copyright © 2016 Adela Gao. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        addFBLoginButton()
    }

    func addFBLoginButton() {
        let fbLoginButton = FBSDKLoginButton()
        fbLoginButton.center = view.center
        view.addSubview(fbLoginButton)
        
    }

}
