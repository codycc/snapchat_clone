//
//  DataService.swift
//  devchatClone
//
//  Created by Cody Condon on 2016-10-18.
//  Copyright © 2016 Cody Condon. All rights reserved.
//

let FIR_CHILD_USERS = "users"
import Foundation
import FirebaseDatabase

class DataService {
    private static let _instance = DataService()
    
    //singleton for the app only used one instance
     static var instance: DataService {
        return _instance
    }
    
    // GRABBING THE database for your app
    var mainRef: FIRDatabaseReference {
        return FIRDatabase.database().reference()
    }
    
    var usersRef: FIRDatabaseReference {
        return mainRef.child(FIR_CHILD_USERS)
    }
    
    func saveUser(uid: String) {
        let profile: Dictionary<String, AnyObject> = ["firstName": "" as AnyObject, "lastName": "" as AnyObject]
        //going to your app reference, then users child then create a uid for the user then setting that child called profile to the dictionary
        mainRef.child(FIR_CHILD_USERS).child(uid).child("profile").setValue(profile)
    }
}
