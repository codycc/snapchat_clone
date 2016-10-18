//
//  AuthService.swift
//  devchatClone
//
//  Created by Cody Condon on 2016-10-17.
//  Copyright © 2016 Cody Condon. All rights reserved.
//

import Foundation
import FirebaseAuth

// block can be called anytime
typealias Completion = (_ errMsg: String?, _ data: AnyObject?) -> Void

class AuthService {
    private static let _instance = AuthService()
    
    static var instance: AuthService {
        return _instance
    }
    
    func login(email: String, password: String, onComplete: Completion?) {
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
                                self.handleFirebaseError(error: error! as NSError, onComplete: onComplete)
                                //Show error to user
                                // else if there is a uid (which is created from signing up, then log in with the email and password
                            } else {
                                
                                if user?.uid != nil {
                                    // calling the dataservice function passing in the user uid
                                    DataService.instance.saveUser(uid: user!.uid)
                                    //Sign in 
                                    FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
                                        if error != nil {
                                            self.handleFirebaseError(error: error! as NSError, onComplete: onComplete)
                                        } else {
                                            onComplete?(nil, user)
                                            // we have successfull logged in!
                                            
                                        }
                                    })
                                }
                            }
                        })
                    }
                } else {
                    self.handleFirebaseError(error: error! as NSError, onComplete: onComplete)
                }
            } else {
                // Successfully logged in 
                onComplete?(nil,user)
            }
        })
    }
    
    func handleFirebaseError(error: NSError, onComplete: Completion?) {
        print(error.description)
        if let errorCode = FIRAuthErrorCode(rawValue: error.code) {
            switch errorCode {
            case .errorCodeInvalidEmail:
                onComplete?("Invalid email address", nil)
                break
            case .errorCodeWrongPassword:
                onComplete?("Invalid password", nil)
                break
            case .errorCodeEmailAlreadyInUse, .errorCodeAccountExistsWithDifferentCredential:
                onComplete?("Could not create account. Email already in use", nil)
                break
            default:
                onComplete?("There was a problem authenticating. Try again", nil)
                break
            }
        }
    }
}
