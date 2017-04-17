//
//  FavoritesViewController.swift
//  RileyCohnFinalProject
//
//  Created by Macy Hanson on 3/20/17.
//  Copyright © 2017 ASU. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancel_clicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    //TODO ALLOW SWIPE TO DELETE FROM THE CORE DATA
    //THIS TABLE VIEW NEEDS TO BE POPULATED BY CORE DATA

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
