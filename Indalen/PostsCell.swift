//
//  PostsCell.swift
//  Indalen
//
//  Created by Fahad Rehman on 12/3/16.
//  Copyright © 2016 Codecture. All rights reserved.
//

import UIKit

class PostsCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var usernameLbl: UILabel!
    
    @IBOutlet weak var emptyHeartImg: UIImageView!
    
    
    @IBOutlet weak var postImg: UIImageView!
    
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var likesLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

 
}
