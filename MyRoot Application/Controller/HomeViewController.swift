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
        
        title = "My Root In Africa"
        
        if(isLoggedIn()){
            self.performSegue(withIdentifier: "moveingToDashBoadFromHome", sender: self)
            
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    fileprivate func isLoggedIn()->Bool{
        return UserDefaults.standard.bool(forKey: "loggedIn")
    }
    
}

