//
//  RegisterViewController.swift
//  RileyCohnFinalProject
//
//  Created by Macy Hanson on 4/16/17.
//  Copyright © 2017 ASU. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    @IBOutlet weak var passText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func register_button_click(_ sender: Any) {
        
        if checkForBlanks() == false
        {
            FIRAuth.auth()?.createUser(withEmail: emailText.text!, password: passText.text!) { (user, error) in
                
                if(error == nil)
                {
                    //successful!
                    //perform log in segue
                    self.performSegue(withIdentifier: "successReg", sender: self)
                }
                else
                {
                    print("error with registration")
                }
            }
        }
        
        else
        {
            //pop up alert unfilled boxes
        }
        
        
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
     */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if (segue.identifier == "successReg")
        {
            //should auto log in user
        }
            

    }
    

        
}

