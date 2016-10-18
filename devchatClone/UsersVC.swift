//
//  UsersVC.swift
//  devchatClone
//
//  Created by Cody Condon on 2016-10-18.
//  Copyright © 2016 Cody Condon. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage

class UsersVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!

    private var users = [User]()
    private var selectedUsers = Dictionary<String, User>()
    
    private var _snapData: Data?
    private var _videoURL: URL?
    
    var snapData: Data? {
        set {
            _snapData = newValue
        } get {
            return _snapData
        }
    }
    
    var videoURL: URL? {
        set {
            _videoURL = newValue
        } get {
            return _videoURL
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsMultipleSelection = true
        //disable navigation button
        navigationItem.rightBarButtonItem?.isEnabled = false
        print("video url in the users vc \(videoURL)")
        // go to all users and take a snapshot
        DataService.instance.usersRef.observeSingleEvent(of: .value, with: { (snapshot) in
            if let users = snapshot.value as? Dictionary<String, AnyObject> {
                // for every key (user) and value (user information) iterate through them
                for (key, value) in users {
                    // set dict as a dictionary of the users information
                    if let dict = value as? Dictionary<String, AnyObject> {
                        // grab the profile out
                        if let profile = dict["profile"] as? Dictionary<String,AnyObject> {
                            // grab the firstname out
                            if let firstName = profile["firstName"] as? String {
                                // set the key which is the uid and create a new User instance from model and append it to the users array
                                let uid = key
                                let user = User(uid: uid, firstName: firstName)
                                self.users.append(user)
                            }
                        }
                    }
                }
            }
            self.tableView.reloadData()
            print("users: \(self.users)")
        })

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell") as! UserCell
        // grab user in indexpath
        let user = users[indexPath.row]
        // call the update ui function
        cell.updateUI(user: user)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationItem.rightBarButtonItem?.isEnabled = true
        // when clicking cell, grab it from indexpath and set to cell constant
        let cell = tableView.cellForRow(at: indexPath) as! UserCell
        // call the setCheckmark function on the cell which will add a checkmark
        cell.setCheckmark(selected: true)
        // let user equal the user at index path
        let user = users[indexPath.row]
        // push the user uid and the user in the selectedUsers dictionary uid is key user is value
        selectedUsers[user.uid] = user
    
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        //opposite of function above
        let cell = tableView.cellForRow(at: indexPath) as! UserCell
        cell.setCheckmark(selected: false)
        let user = users[indexPath.row]
        selectedUsers[user.uid] = nil
        
        // enable to send to multiple users 
        if selectedUsers.count <= 0 {
            navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    @IBAction func sendPRBtnPressed(sender: AnyObject) {
        print("BUTTON IS PRESSED")
        // for videos
        if let url = _videoURL {
            let videoName = "\(NSUUID().uuidString)\(url)"
            let ref = DataService.instance.videoStorageRef.child(videoName)
            
            _ = ref.putFile(url, metadata: nil, completion: { (meta: FIRStorageMetadata?, err: Error?) in
                if err != nil {
                     print("Error uploading video: \(err?.localizedDescription)")
                } else {
                    
                    // once video is successfully uploaded to firebase, itll send back a download url
                   let downloadURL = meta!.downloadURL()
                    print("Download Url: \(downloadURL)")
                    
                    // once snap is sent itll dismiss the users vc
                    self.dismiss(animated: true, completion: nil)
                }
            })
            // for photos
        } else if let snap = _snapData {
            let ref = DataService.instance.imagesStorageRef.child("\(NSUUID().uuidString).jpg")
            
            _ = ref.put(snap, metadata: nil, completion: { (meta:FIRStorageMetadata?, err: Error?) in
                if err != nil {
                    print("Error uploading snapshot: \(err?.localizedDescription)")
                } else {
                    let downloadURL = meta!.downloadURL()
                    self.dismiss(animated: true, completion: nil)
                }
            })
        }
    }

  
  

}
