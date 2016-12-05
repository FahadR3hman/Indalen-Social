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

class FeedVC: UIViewController , UITableViewDelegate , UITableViewDataSource , UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    // UIImagePickerControllerDelegate , UINavigationControllerDelegate for images
    
    @IBOutlet weak var addImage: ImageCircle!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var posts = [Post]()
    var imagePicker : UIImagePickerController!
    
    static var imageCache = NSCache<AnyObject, AnyObject>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            addImage.image = image
        } else {
            print("valid image not selected fahad::")
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
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
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? PostsCell {
            
            if let img = FeedVC.imageCache.object(forKey: post.imageURL as AnyObject) {
                cell.ConfigureCell(post: post, img: img as? UIImage)
                return cell
            } else {
                cell.ConfigureCell(post: post, img: nil)
                return cell

            }
            
        } else {
            return PostsCell()
        }
        //return (tableView.dequeueReusableCell(withIdentifier: "cell") as? PostsCell)!
    }
    
    
    @IBAction func AddImageTapped(_ sender: Any) {
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
