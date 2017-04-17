//
//  DetailViewController.swift
//  RileyCohnFinalProject
//
//  Created by Macy Hanson on 3/18/17.
//  Copyright © 2017 ASU. All rights reserved.
//

import UIKit
import Firebase

var testComments: [String] = ["Comment1", "Comment2", "Comment3"]

var comments: [Comment] = []

var postRef = postCategoryRef.child("null")

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var post: String = ""
    var postID = ""

    @IBOutlet weak var postText: UITextView!
    @IBOutlet weak var commentTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        postText.text = post
        self.navigationController?.isToolbarHidden = false

        // Do any additional setup after loading the view.
        
        //postRef hold the information needed to view/post comments for the post that was selected
        
        postRef = postCategoryRef.child(postID)
        
        postRef.observe(.value, with: { snapshot in
            // 2
            var newItems: [Comment] = []
            
            // 3
            for item in snapshot.children {
                // 4
                let comment = Comment(snapshot: item as! FIRDataSnapshot)
                newItems.append(comment)
            }
            
            // 5
            comments = newItems
            self.commentTable.reloadData()
        })

    }
    
    override func viewWillAppear(_ animated: Bool){
        commentTable.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = comments[indexPath.row].body
        
        return cell;
    }

    @IBAction func savePost(_ sender: UIBarButtonItem) {
        //save the post as core data that can be viewed by accesing the favorites page from the menu
        
    }
    
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "newComment"{
            
            if let commentviewController: NewCommentViewController = segue.destination as? NewCommentViewController {
                commentviewController.postID = self.postID

            }
        }
    }
}
