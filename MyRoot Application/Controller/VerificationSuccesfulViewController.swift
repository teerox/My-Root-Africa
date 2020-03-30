//
//  VerificationSuccesfulViewController.swift
//  MyRoot Application
//
//  Created by macbook on 3/18/20.
//  Copyright © 2020 Decagon. All rights reserved.
//

import Foundation
import UIKit

class VerificationSuccessfulViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationController?.setToolbarHidden(true, animated: false)
    }
    
    @IBAction func verifySuccessful(_ sender: UIButton) {
        
        navigationController?.popToRootViewController(animated: true)
    }
    
    
}
