//
//  FeedViewController.swift
//  SpectacularSportBuddies
//
//  Created by Adela Gao on 7/23/16.
//  Copyright © 2016 Adela Gao. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import SwiftyJSON

class FeedViewController: UIViewController {

    var ref: FIRDatabaseReference!
    @IBOutlet weak var createPostButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    private var _refHandle: FIRDatabaseHandle!
    var posts = [Post]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        ref = FIRDatabase.database().reference()
        configureDatabase()
        // Do any additional setup after loading the view.
    }
    
    func setupTable() {
        tableView.registerNib(UINib(nibName: Constants.CellIdentifiers.postCell, bundle: nil), forCellReuseIdentifier: Constants.CellIdentifiers.postCell)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = CGFloat(Constants.CellHeights.postCellHeight)
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    @IBAction func createPostButtonTapped(sender: UIButton) {
        let createPostVC = CreatePostViewController()
        navigationController?.pushViewController(createPostVC, animated: true)
    }
    
    func configureDatabase() {
        ref = FIRDatabase.database().reference()
        // Listen for new messages in the Firebase database
        _refHandle = self.ref.child("posts").observeEventType(.ChildAdded, withBlock: { (snapshot) -> Void in
            let snapDict = snapshot.value as! [String: AnyObject]
            let username = snapDict[Constants.PostFields.username] as! String
            let postTime = snapDict[Constants.PostFields.postTime] as! Double
            let sportType = snapDict[Constants.PostFields.sportType] as! String
            let timeRange = snapDict[Constants.PostFields.timeRange] as! String
            let location = snapDict[Constants.PostFields.location] as! String
            let post = Post(username: username, timeRange: timeRange, location: location, sportType: sportType, postTime: postTime)
            self.posts.append(post)
            self.tableView.reloadData()
            self.tableView.setNeedsLayout()
            // TODO: insertRowsAtIndexPaths
            //self.tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: self.posts.count-1, inSection: 0)], withRowAnimation: .Automatic)
        })
    }
}

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: UITableViewDelegate:

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Constants.CellIdentifiers.postCell, forIndexPath: indexPath) as! PostTableViewCell
        cell.post = posts[indexPath.row]
        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

    }
}
