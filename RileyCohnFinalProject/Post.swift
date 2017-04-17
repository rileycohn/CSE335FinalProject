//
//  Post.swift
//  RileyCohnFinalProject
//
//  Created by Macy Hanson on 4/16/17.
//  Copyright © 2017 ASU. All rights reserved.
//

import Foundation
import Firebase

struct Post
{
    let postID: String
    let username: String
    let body: String
    let ref: FIRDatabaseReference?
    
    init(postID: String, username: String, body: String) {
        self.postID = postID
        self.username = username
        self.body = body
        self.ref = nil
    }
    
    init(snapshot: FIRDataSnapshot) {
        
        let snapshotValue = snapshot.value as! [String: AnyObject]
        
            //print(snapshotValue?["postID"] as! String)
        if let pID = snapshotValue["postID"] as? String{
            self.postID = pID
        }
        else{
            self.postID = ""
        }
        
        if let uname = snapshotValue["username"] as? String{
            self.username = uname
        }
        else{
            self.username = ""
        }
        
        if let bdy = snapshotValue["body"] as? String{
            self.body = bdy
        }
        else{
            self.body = ""
        }
        self.ref = snapshot.ref
        
    }
    
    func toAnyObject() -> Any {
        return [
            "postID": postID,
            "username": username,
            "body": body,
        ]
    }
    
}
