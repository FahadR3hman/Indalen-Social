//
//  PostsCell.swift
//  Indalen
//
//  Created by Fahad Rehman on 12/3/16.
//  Copyright © 2016 Codecture. All rights reserved.
//

import UIKit
import Firebase

class PostsCell: UITableViewCell {
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var usernameLbl: UILabel!
    
    @IBOutlet weak var emptyHeartImg: UIImageView!
    
    
    @IBOutlet weak var postImg: UIImageView!
    
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var likesLbl: UILabel!
    
    var post: Post!
    var likesRef = FIRDatabaseReference()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(liketapped))
        tap.numberOfTapsRequired = 1
        emptyHeartImg.addGestureRecognizer(tap)
        
        emptyHeartImg.isUserInteractionEnabled = true
    }
    
    func liketapped(sender : UITapGestureRecognizer) {
        likesRef.observeSingleEvent(of: .value, with: { (snapshot) in
            if let _ = snapshot.value as? NSNull {
                self.emptyHeartImg.image = UIImage(named: "filled-heart")
                self.post.adjustLikes(addlike: true)
                self.likesRef.setValue(true)
            } else {
                self.emptyHeartImg.image = UIImage(named: "empty-heart")
                self.post.adjustLikes(addlike: false)
                self.likesRef.removeValue()
            }
        })
    }
    
    func ConfigureCell(post : Post , img:UIImage?) {
        self.post = post
        likesRef = DataService.db.Db_CURRENT_USER.child("likes").child(post.postkey)
        self.textView.text = post.caption
        self.likesLbl.text = "\(post.likes)"
        
        if img != nil {
            self.postImg.image = img
        } else {
            
            let ref = FIRStorage.storage().reference(forURL: post.imageURL)
            ref.data(withMaxSize: 2 * 1024 * 1024, completion: { (data, error) in //size of 2MB
                
                if error != nil {
                    print("Fahad: Couldn't download image from the Firebase Storage")
                } else {
                    print("Fahad: Image Downloaded from the firebase")
                    if let imgData = data {
                        if let img = UIImage(data: imgData) {
                            self.postImg.image = img
                            FeedVC.imageCache.setObject(img, forKey: post.imageURL as AnyObject )
                        }
                    }
                }
                
            })
            
            
        }
        
        //liking something if not liked
        
        likesRef.observeSingleEvent(of: .value, with: { (snapshot) in
            if let _ = snapshot.value as? NSNull {
                self.emptyHeartImg.image = UIImage(named: "empty-heart")
                //post.adjustLikes(addlike: false)
            } else {
                self.emptyHeartImg.image = UIImage(named: "filled-heart")
                //post.adjustLikes(addlike: true)
            }
            
        })
        
    }
    
}






