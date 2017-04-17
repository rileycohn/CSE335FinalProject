//
//  NewPostViewController.swift
//  RileyCohnFinalProject
//
//  Created by Macy Hanson on 3/19/17.
//  Copyright © 2017 ASU. All rights reserved.
//

import UIKit
import Firebase

class NewPostViewController: UIViewController {
    
    @IBOutlet weak var postText: UITextView!

    override func viewDidLoad() {
       super.viewDidLoad()
        
        let borderColor = UIColor.black.cgColor
        postText.layer.borderColor = borderColor
        postText.layer.borderWidth = 1.0
        postText.layer.cornerRadius = 5.0

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

        let postsChildRef = postCategoryRef.childByAutoId()
        
        let newPost = Post(postID: postsChildRef.key, username: (FIRAuth.auth()?.currentUser)!.email!, body: postText.text)
        
        print(postsChildRef.key)
        postsChildRef.setValue(newPost.toAnyObject())
        
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
