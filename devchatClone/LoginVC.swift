//
//  LoginVC.swift
//  devchatClone
//
//  Created by Cody Condon on 2016-10-17.
//  Copyright © 2016 Cody Condon. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    @IBOutlet weak var emailField: RoundTextField!

    @IBOutlet weak var passwordField: RoundTextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginPressed(_ sender: AnyObject) {
        // let email and pass constants get grabbed from the fields if character count higher than zero
        if let email = emailField.text, let pass = passwordField.text , (email.characters.count > 0 && pass.characters.count > 0 ) {
            
            // let the email and password get passed to login function
            AuthService.instance.login(email: email, password: pass)
            
        } else {
            // setting the alert letting user know about entering more characters
            let alert = UIAlertController(title: "Username and Password Required", message: "You must enter both a username and password", preferredStyle: .alert)
            // allows user to cancel
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            // presenting the alert to the user
            present(alert, animated: true, completion: nil)
        }
        
    }

}
