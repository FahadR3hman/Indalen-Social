//
//  ViewController.swift
//  Indalen
//
//  Created by Fahad Rehman on 11/30/16.
//  Copyright © 2016 Codecture. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase
import SwiftKeychainWrapper

class LoginVC: UIViewController {

    @IBOutlet weak var emailField: RoundTextField!
    
    @IBOutlet weak var pwdField: RoundTextField!
    
    @IBAction func loginTapped(_ sender: Any) {
        
        print("Button Tapped")
        
        if let email = emailField.text, let password = pwdField.text {
            
            if password.characters.count < 6 {
                print("The password is too short")
            }
            
            FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
                
                if error == nil {
                    print("Fahad: Logged in with email and password")
                    if let user = user {
                        let userdata = ["provider": user.providerID]
                        self.completeSignIn(id: user.uid , userdata: userdata )
                        
                    }
                    
                } else {
                    FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
                        if error != nil {
                            print("Fahad: Authentication failed with firebase")
                        } else {
                            print("Successfully Authenticated With Firebase")
                            if let user = user {
                                let userdata = ["provider": user.providerID]
                                self.completeSignIn(id: user.uid , userdata: userdata )
                                
                            }
                        }
                    })
                    
                }
            })
        }
        
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewDidAppear(_ animated: Bool) {
        if let _ = KeychainWrapper.standard.string(forKey: key_uid) {
            performSegue(withIdentifier: "feed", sender: nil)
        }
    }
    
    

    @IBAction func fbBtnTapped(_ sender: Any) {
        
        let fblogin = FBSDKLoginManager()
        
        fblogin.logIn(withReadPermissions: ["email"], from: self) { (result , error) in
            
            if error != nil {
                print("Fahad: Failed to authenticate with Facebook")
            }
            else if result?.isCancelled == true {
                print ("Fahad: User cancelled the permission")
            }
            else {
                print("Fahad: Logged in")
                
                
                let credentials = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.FirebaseAuth(credentials)
            }
        }
    }
    
    
    func FirebaseAuth(_ credentials: FIRAuthCredential) {
        FIRAuth.auth()?.signIn(with: credentials, completion: { (user, error) in
            if error != nil {
                print("unable to authenticate with firebase : Fahad")
            } else {
                print("Authenticated with firebase")
                if let user = user {
                    let userdata = ["provider": credentials.provider]
                    print(credentials.provider)
                    self.completeSignIn(id: user.uid , userdata: userdata )
                    
                }


                
                        }
        })
    }
    
    
    
    
    
    
    
    func completeSignIn(id: String , userdata: Dictionary<String, String>) {
        DataService.db.createUserDB(uid: id, userdata: userdata)
        KeychainWrapper.standard.set(id, forKey: key_uid)
        performSegue(withIdentifier: "feed", sender: nil)
    }
    
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    

}








