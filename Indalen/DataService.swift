//
//  DataService.swift
//  Indalen
//
//  Created by Fahad Rehman on 12/4/16.
//  Copyright © 2016 Codecture. All rights reserved.
//

import Foundation
import Firebase
// Adding user to the firebase database.

let db_base = FIRDatabase.database().reference()

class DataService {
    
    static let db = DataService() //db is the instance of the class Dataservice
    
    private var _DB_REF = db_base
    private var _DB_POSTS = db_base.child("posts")
    private var _DB_USERS = db_base.child("users") // referencing a table
    
    var DB_REF : FIRDatabaseReference {
        return _DB_REF
    }
    
    var DB_POSTS : FIRDatabaseReference {
        return _DB_POSTS
    }
    
    var DB_USERS : FIRDatabaseReference {
        return _DB_USERS
    }
    
    func createUserDB (uid: String , userdata : Dictionary <String , String>) {
        DB_USERS.child(uid).updateChildValues(userdata)
    }
    
    
}


