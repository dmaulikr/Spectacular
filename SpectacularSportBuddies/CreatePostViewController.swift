//
//  CreatePostViewController.swift
//  SpectacularSportBuddies
//
//  Created by Adela Gao on 7/23/16.
//  Copyright © 2016 Adela Gao. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class CreatePostViewController: UIViewController {

    var ref: FIRDatabaseReference!
    var postTime: Double!
    
    var pickerSelections = [String]()
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var postButton: UIButton!
    
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!
    var selectedSports: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = FIRDatabase.database().reference()
        setupPicker()
        setupDismissKeyboard()
        // Do any additional setup after loading the view.
    }

    @IBAction func postButtonTapped(sender: UIButton) {
        sendPost()
    }
    
    func setupDismissKeyboard() {
        locationTextField.delegate = self
        timeTextField.delegate = self
    }
    
    func setupPicker() {
        picker.delegate = self
        picker.dataSource = self
        picker.showsSelectionIndicator = true
        pickerSelections = ["Belaying", "Tennis", "Soccer"]
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func sendPost() {
        if var post : [String : AnyObject] = [
            Constants.PostFields.username: AppState.sharedInstance.username,
        Constants.PostFields.sportType: pickerSelections[picker.selectedRowInComponent(0)],
            Constants.PostFields.timeRange: timeTextField.text!,
            Constants.PostFields.location: locationTextField.text!
            ] {
            postTime = NSDate().timeIntervalSince1970
            post[Constants.PostFields.postTime] = postTime

            ref.child("posts").childByAutoId().setValue(post, withCompletionBlock: { (error:NSError?, dbRef: FIRDatabaseReference) in
                print("post successful!")
                let alert = UIAlertController(title: "Success", message: "Post success", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: {(action) in
                    self.navigationController?.popViewControllerAnimated(true)
                    
                }))
                self.presentViewController(alert, animated: true, completion: nil)
            })
        }
    }
}

extension CreatePostViewController: UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerSelections.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerSelections[row]
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
    
}
