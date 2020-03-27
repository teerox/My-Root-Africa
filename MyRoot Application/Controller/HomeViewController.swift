//
//  ViewController.swift
//  MyRoot Application
//
//  Created by macbook on 3/12/20.
//  Copyright © 2020 Decagon. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
 
        
        if(isLoggedIn()){
             self.performSegue(withIdentifier: "moveingToDashBoadFromHome", sender: self)

        }
 
    }

    fileprivate func isLoggedIn()->Bool{
        return UserDefaults.standard.bool(forKey: "loggedIn")
    }
    
}

