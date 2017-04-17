//
//  LogInViewController.swift
//  RileyCohnFinalProject
//
//  Created by Macy Hanson on 4/16/17.
//  Copyright © 2017 ASU. All rights reserved.
//

import UIKit
import Firebase

class LogInViewController: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkForBlanks() -> Bool
    {
        if (emailText.text?.isEmpty)!{
            return true
        }
            
        else if (passText.text?.isEmpty)!{
            return true
        }
            
        else{
            return false
        }
    }
    
    @IBAction func sign_in_button(_ sender: Any) {
        
        if checkForBlanks() == false{
            FIRAuth.auth()?.signIn(withEmail: emailText.text!, password: passText.text!) { (user, error) in
                
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                else{
                    //perform segue log in
                    self.performSegue(withIdentifier: "signIn", sender: self)
                }
            }
        }
        
        else{
            //popup error
            print("should print here if a blank")
            
        }
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
