//
//  AppDelegate.swift
//  SpectacularSportBuddies
//
//  Created by Adela Gao on 7/23/16.
//  Copyright © 2016 Adela Gao. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FBSDKCoreKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        FIRApp.configure()
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        let frame = UIScreen.mainScreen().bounds
        window = UIWindow(frame: frame)
        
        let loginVC = LoginViewController()
        window?.rootViewController = loginVC
        window?.makeKeyAndVisible()

        if FBSDKAccessToken.currentAccessToken() != nil {
            FBSDKProfile.enableUpdatesOnAccessTokenChange(true)
            retrieveUserProfile()
            skipLoginScreen()
        }

        return true
    }
    
    func retrieveUserProfile() {
        let accessToken = FBSDKAccessToken.currentAccessToken()
        let nameRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"name"], tokenString: accessToken.tokenString, version: nil, HTTPMethod: "GET")
        nameRequest.startWithCompletionHandler { (connection, result, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                AppState.sharedInstance.username = result["name"] as! String
                print(AppState.sharedInstance.username)
            }
        }
    }
    
    //fb login
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        let handled = FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
        return handled
    }
    
    func skipLoginScreen() {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let tabVC = TabBarViewController()
        let feedVC = FeedViewController()
        let inboxVC = InboxViewController()
        let profileVC = ProfileViewController()
        
        feedVC.title = "Workouts"
        
        inboxVC.title = "Inbox"
        
        profileVC.title = "Profile"

        let feedNavController = UINavigationController()
        feedNavController.tabBarItem.title = "Workouts"
        feedNavController.viewControllers = [feedVC]
        
        let inboxNavController = UINavigationController()
        inboxNavController.tabBarItem.title = "Inbox"
        inboxNavController.viewControllers = [inboxVC]
        
        let profileNavController = UINavigationController()
        profileNavController.title = "Profile"
        profileNavController.viewControllers = [profileVC]
        
        tabVC.viewControllers = [feedNavController, inboxNavController, profileNavController]
        appDelegate.window?.rootViewController = tabVC
        appDelegate.window?.makeKeyAndVisible()
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        FBSDKAppEvents.activateApp()
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

