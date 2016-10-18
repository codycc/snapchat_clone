//
//  DataService.swift
//  devchatClone
//
//  Created by Cody Condon on 2016-10-18.
//  Copyright © 2016 Cody Condon. All rights reserved.
//

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
    
    func saveUser(uid: String) {
        let profile: Dictionary<String, AnyObject> = ["firstname": "" as AnyObject, "lastname": "" as AnyObject]
        //going to your app reference, then users child then create a uid for the user then setting that child called profile to the dictionary
        mainRef.child("users").child(uid).child("profile").setValue(profile)
    }
}
