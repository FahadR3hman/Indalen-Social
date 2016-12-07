//
//  DataService.swift
//  Indalen
//
//  Created by Fahad Rehman on 12/4/16.
//  Copyright © 2016 Codecture. All rights reserved.
//

import Foundation
import Firebase
import SwiftKeychainWrapper
// Adding user to the firebase database.

let db_base = FIRDatabase.database().reference()
let storage_base = FIRStorage.storage().reference()

class DataService {
    
    static let db = DataService() //db is the instance of the class Dataservice
    
    
    //database references
    private var _DB_REF = db_base
    private var _DB_POSTS = db_base.child("posts")
    private var _DB_USERS = db_base.child("users") // referencing a table
    
    
    //storage references
   
    private var _storage_folder = storage_base.child("posts-pics")
    
    var storage_folder : FIRStorageReference {
        return _storage_folder
    }
    
    var DB_REF : FIRDatabaseReference {
        return _DB_REF
    }
    
    var DB_POSTS : FIRDatabaseReference {
        return _DB_POSTS
    }
    
    var DB_USERS : FIRDatabaseReference {
        return _DB_USERS
    }
    
    var Db_CURRENT_USER: FIRDatabaseReference {
         let uid = KeychainWrapper.standard.string(forKey: key_uid)
        let user = DB_USERS.child(uid!)
        return user
        
    }
    
    func createUserDB (uid: String , userdata : Dictionary <String , String>) {
        DB_USERS.child(uid).updateChildValues(userdata)
    }
    
    
}


