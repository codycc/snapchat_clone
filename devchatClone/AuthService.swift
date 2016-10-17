//
//  AuthService.swift
//  devchatClone
//
//  Created by Cody Condon on 2016-10-17.
//  Copyright © 2016 Cody Condon. All rights reserved.
//

import Foundation
import FirebaseAuth

class AuthService {
    private static let _instance = AuthService()
    
    static var instance: AuthService {
        return _instance
    }
    
    func login(email: String, password: String) {
        // taking the code from the login vc passing into this function which is passing into firebase auth methods
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            
            if error != nil {
                // if their is an error, lets see what the error code is
                if let errorCode = FIRAuthErrorCode(rawValue: error!._code) {
                    // if the error code is the user is not found
                    if errorCode == .errorCodeUserNotFound {
                        // then create a user with the email and password
                        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
                            // if their is an error at this level, then display here..
                            if error != nil {
                                //Show error to user
                                // else if there is a uid (which is created from signing up, then log in with the email and password
                            } else {
                                
                                if user?.uid != nil {
                                    //Sign in 
                                    FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
                                        if error != nil {
                                            //show error to user
                                        } else {
                                            // we have successfull logged in!
                                            
                                        }
                                    })
                                }
                            }
                        })
                    }
                } else {
                    // Handle other error codes
                }
            } else {
                // Successfully logged in 
            }
        })
    }
}
