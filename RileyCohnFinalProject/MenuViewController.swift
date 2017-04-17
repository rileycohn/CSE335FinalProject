//
//  MenuViewController.swift
//  RileyCohnFinalProject
//
//  Created by Macy Hanson on 3/19/17.
//  Copyright © 2017 ASU. All rights reserved.
//

import UIKit
import Firebase

var testClasses = ["General", "ASU Football", "CSE 335"]

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var profilePic: UIImageView!
    let picker = UIImagePickerController()
    
    @IBOutlet weak var classTable: UITableView!
    
    @IBOutlet weak var emailLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setToolbarHidden(false, animated: false)
        
        picker.delegate = self
        
        self.profilePic.layer.cornerRadius = self.profilePic.frame.size.width / 2
        self.profilePic.clipsToBounds = true
        
        self.profilePic.image = UIImage(named: "profilePic.png")
        
        emailLabel.text = FIRAuth.auth()?.currentUser?.email
        
        DispatchQueue.global(qos: .background).async
            {
                let storage = FIRStorage.storage()
                
                let storageRef = storage.reference()
                
                //get profile image from storage and set the image to that
                
                let profileRef = storageRef.child("\(self.emailLabel.text!).png")
                
                // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
                profileRef.data(withMaxSize: 1 * 1024 * 1024) { data, error in
                    if let error = error {
                        // Uh-oh, an error occurred!
                        print(error.localizedDescription)
                    } else {
                        // Data for "email" is returned
                        let image = UIImage(data: data!)
                        self.profilePic.image = image
                    }
                }

        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeButtonClicked(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return testClasses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = testClasses[indexPath.row]
        
        return cell;
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        //upload image to database right here for persistence
        profilePic.image = chosenImage
        uploadNewPic()
        dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func photoFromLibrary(_ sender: UIButton) {
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(picker, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if (segue.identifier == "newClass")
        {
            let selectedIndex: IndexPath = self.classTable.indexPath(for: sender as! UITableViewCell)!
                
                currClass = testClasses[selectedIndex.row]
                
        }
        
    }
    
    //called after new image is selected from drop down
    func uploadNewPic(){
        
        let storage = FIRStorage.storage()
        
        let storageRef = storage.reference()
        
        let smallImg = resizeImage(image: profilePic.image!, newWidth: 150.0)
        
        if let img = smallImg {
            let data = UIImagePNGRepresentation(img) as NSData?
        
        
            // Create a reference to the file you want to upload
            let emailRef = storageRef.child("\(emailLabel.text!).png")
        
            // Upload the file to the path "user email"
            let uploadTask = emailRef.put(data as! Data, metadata: nil) { (metadata, error) in
                guard let metadata = metadata else {
                    // Uh-oh, an error occurred!
                    return
                }
                // Metadata contains file metadata such as size,    content-type, and download URL.
                let downloadURL = metadata.downloadURL
            }
        }
    }
    
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage? {
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
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
