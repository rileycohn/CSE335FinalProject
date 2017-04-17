//
//  Comment.swift
//  RileyCohnFinalProject
//
//  Created by Macy Hanson on 4/16/17.
//  Copyright © 2017 ASU. All rights reserved.
//

import Foundation
import Firebase

struct Comment
{
    let postID: String
    let commentID: String
    let username: String
    let body: String
    let ref: FIRDatabaseReference?
    
    init(postID: String, username: String, body: String, commentID: String) {
        self.postID = postID
        self.username = username
        self.body = body
        self.ref = nil
        self.commentID = commentID
    }
    
    init(snapshot: FIRDataSnapshot) {
        
        if let snapshotValue = snapshot.value as? [String: AnyObject]
        {
            //print(snapshotValue?["postID"] as! String)
            postID = snapshotValue["postID"] as! String
            username = snapshotValue["username"] as! String
            body = snapshotValue["body"] as! String
            ref = snapshot.ref
            commentID = snapshotValue["commentID"] as! String
        }
            
        else
        {
            print("error with snapshot")
            postID = ""
            username = ""
            body = ""
            ref = nil
            commentID = ""
        }
        
    }
    
    func toAnyObject() -> Any {
        return [
            "postID": postID,
            "username": username,
            "body": body,
            "commentID": commentID
        ]
    }
    
}
