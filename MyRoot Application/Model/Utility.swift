//
//  Utility.swift
//  MyRoot Application
//
//  Created by macbook on 3/19/20.
//  Copyright © 2020 Decagon. All rights reserved.
//

import Foundation
import UIKit

class Utility: UIViewController {
    
    let API = "https://fathomless-badlands-69782.herokuapp.com/api/"
    
    func validate(input:String) -> Bool {
         if(input != ""){
             return true
         }
         return false
     }
    
    func showAlert(for alert: String) {
          let alertController = UIAlertController(title: nil, message: alert, preferredStyle: UIAlertController.Style.alert)
          let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
          alertController.addAction(alertAction)
          present(alertController, animated: true, completion: nil)
      }
    
}
