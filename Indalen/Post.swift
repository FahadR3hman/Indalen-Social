//
//  Post.swift
//  Indalen
//
//  Created by Fahad Rehman on 12/5/16.
//  Copyright © 2016 Codecture. All rights reserved.
//

import Foundation

class Post {
    private var _caption: String!
    private var _imageURL : String!
    private var _likes: Int!
    private var _postkey: String!
    
    var caption: String {
        return _caption
    }
    var imageURL: String {
        return _imageURL
    }
    var likes:Int {
        return _likes
    }
    var postkey: String {
        return _postkey
    }
    
    init(caption: String , imageURL: String , likes: Int) {
        self._caption = caption
        self._imageURL = imageURL
        self._likes = likes
    }
    
    init(postkey: String , postdata: Dictionary<String, AnyObject>) {
        //converting the firebase data
        
        self._postkey = postkey
        if let caption = postdata["caption"] as? String {
            self._caption = caption
        }
        if let imageURL = postdata["imageURL"] as? String {
            self._imageURL = imageURL
        }
        if let likes = postdata ["likes"] as? Int {
            self._likes = likes
        }
        
    }
}
