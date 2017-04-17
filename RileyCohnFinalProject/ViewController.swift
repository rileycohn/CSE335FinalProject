//
//  ViewController.swift
//  RileyCohnFinalProject
//
//  Created by Macy Hanson on 3/18/17.
//  Copyright © 2017 ASU. All rights reserved.
//

import UIKit
import Firebase

var currClass = "General"

var posts: [Post] = []
var user: User!

let ref = FIRDatabase.database().reference(withPath: "posts")

var postCategoryRef = ref.child(currClass)


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var postsTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.topItem?.title = currClass
        self.navigationController?.navigationBar.isHidden = false
        // Do any additional setup after loading the view, typically from a nib.
        
        postCategoryRef = ref.child(currClass)
        
        postCategoryRef.observe(.value, with: { snapshot in
            // 2
            var newItems: [Post] = []
            
            // 3
            for item in snapshot.children {
                // 4
                let post = Post(snapshot: item as! FIRDataSnapshot)
                newItems.append(post)
            }
            
            // 5
            posts = newItems
            self.postsTable.reloadData()
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        postsTable.reloadData()
        print(currClass)
        self.navigationController?.navigationItem.title = currClass
        self.navigationController?.navigationBar.isHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(posts.count)
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = posts[indexPath.row].body
        
        return cell;
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if (segue.identifier == "showDetails")
        {
            let selectedIndex: IndexPath = self.postsTable.indexPath(for: sender as! UITableViewCell)!
            
            if let detailviewController: DetailViewController = segue.destination as? DetailViewController {
                detailviewController.post = posts[selectedIndex.row].body;
                
                detailviewController.postID = posts[selectedIndex.row].postID
            }
        }
        
        else if (segue.identifier == "addPost")
        {
            if let _: NewPostViewController = segue.destination as? NewPostViewController {
                
            }
        }
    }

}

