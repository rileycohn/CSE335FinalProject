//
//  NewCommentViewController.swift
//  RileyCohnFinalProject
//
//  Created by Macy Hanson on 3/19/17.
//  Copyright © 2017 ASU. All rights reserved.
//

import UIKit
import Firebase

class NewCommentViewController: UIViewController {

    @IBOutlet weak var commentText: UITextView!
    var postID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let borderColor = UIColor.black.cgColor
        commentText.layer.borderColor = borderColor
        commentText.layer.borderWidth = 1.0
        commentText.layer.cornerRadius = 5.0
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func deleteButtonClicked(_ sender: UIBarButtonItem) {
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonClicked(_ sender: UIBarButtonItem) {
        //add to firebase here
        
        let commentRef = postRef.childByAutoId()
        
        let newComment = Comment(postID: postID, username: (FIRAuth.auth()?.currentUser)!.email!, body: commentText.text, commentID: commentRef.key)
        
        print(commentRef.key)
        commentRef.setValue(newComment.toAnyObject())
        
        dismiss(animated: true, completion: nil)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
