//
//  UsersVC.swift
//  devchatClone
//
//  Created by Cody Condon on 2016-10-18.
//  Copyright © 2016 Cody Condon. All rights reserved.
//

import UIKit
import FirebaseDatabase

class UsersVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!

    private var users = [User]()
    private var selectedUsers = Dictionary<String, User>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsMultipleSelection = true
        
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
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

  
  

}
