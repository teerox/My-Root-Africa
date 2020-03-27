//
//  ForgotPasswordViewController.swift
//  MyRoot Application
//
//  Created by macbook on 3/18/20.
//  Copyright © 2020 Decagon. All rights reserved.
//

import Foundation
import UIKit

class ForgotPasswordViewController: UIViewController {
    
    @IBOutlet weak var emailForForgotPassword: UITextField!
    
    var ApiData = Utility()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
    }
    
    
    @IBAction func submitButton(_ sender: UIButton) {
        validate()
    }
    
    
    func validate(){
          self.showSpinner(onView: self.view)
          do {
              let userEmail = try emailForForgotPassword.validatedTexts(validationTypes: ValidatorType.email)
                    let endpoint = "auth/forgot-password"
                    let url = "\(ApiData.API)\(endpoint)"
                    let data = ForgotPasswordEmail(email: userEmail)
            print(url)
            ForgotPassword.shared.save(urlString: url, email: data){ (success, error, result) in
                 if success {
                              let response = result!
                              let status = response.status
                              let message = response.message
                             
                       if (status == 200){
                        print("My Response:\(response)")
                           DispatchQueue.main.async {
                               self.removeSpinner()
                               self.performSegue(withIdentifier: "movetoResetPassword", sender: self)
                               self.showAlert(for: message)
                   
                               }
                           
                       }else{
                           DispatchQueue.main.async {
                                      self.showAlert(for: message)
                                      self.removeSpinner()
                        }
                       }
                   
                   }else{
                       print(error!)
                   }
            }
            
    
          }catch(let error) {
          showAlert(for: (error as! ValidationError).message)
          self.removeSpinner()
      }

    }
    
    
    func showAlert(for alert: String) {
        let alertController = UIAlertController(title: nil, message: alert, preferredStyle: UIAlertController.Style.alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    
}

