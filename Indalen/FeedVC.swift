//
//  FeedVC.swift
//  Indalen
//
//  Created by Fahad Rehman on 12/1/16.
//  Copyright © 2016 Codecture. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class FeedVC: UIViewController , UITableViewDelegate , UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    

    @IBAction func signOutTapped(_ sender: Any) {
        
        KeychainWrapper.standard.remove(key: key_uid)
        do {
            try FIRAuth.auth()?.signOut()
        } catch {
            
        }
        performSegue(withIdentifier: "login", sender: nil)
        
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return (tableView.dequeueReusableCell(withIdentifier: "cell") as? PostsCell)!
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
