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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func ConfigureCell(post : Post , img:UIImage?) {
        self.post = post
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
        
        
    }
    
}






