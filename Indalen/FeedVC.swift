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

    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        DataService.db.DB_POSTS.observe(.value , with:{ (snapshot) in //listener
           // print(snapshot.value )
            
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshot {
                    print("Snap: \(snap)")
                    
                    if let postDict = snap.value as? Dictionary <String , AnyObject> {
                        let key = snap.key
                        let post = Post(postkey: key, postdata: postDict)
                        self.posts.append(post)
                    }
                }
            }
            self.tableView.reloadData()
        })
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
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let post = posts[indexPath.row]
        print("Fahad: \(post.caption)")
        return (tableView.dequeueReusableCell(withIdentifier: "cell") as? PostsCell)!
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
