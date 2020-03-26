//
//  ForgotPasswordVerification.swift
//  MyRoot Application
//
//  Created by macbook on 3/25/20.
//  Copyright © 2020 Decagon. All rights reserved.
//

import Foundation
import UIKit

class ForgotPasswordVerification: UIViewController {
    
    @IBOutlet weak var emailVerify: UITextField!
    
    @IBOutlet weak var codeVerify: UITextField!
    
    @IBOutlet weak var passwordVerify: UITextField!
    
    var ApiData = Utility()
    
    override func viewDidLoad() {
           super.viewDidLoad()
        
       }

 
    @IBAction func submitButton(_ sender: UIButton) {
        validate()
    }
    
    
    
    func validate(){
          self.showSpinner(onView: self.view)
          do {
             let userEmail = try self.emailVerify.validatedText(validationType: ValidatorType.email)
            let userCode = try self.codeVerify.validatedText(validationType: ValidatorType.codeValidator)
              let userPassword = try self.passwordVerify.validatedText(validationType: ValidatorType.password)
            
                    let endpoint = "auth/reset-password"
                    let url = "\(ApiData.API)\(endpoint)"
                    let data = ResetPasswordValues(email: userEmail, code: userCode, password: userPassword)
            
            ResetPassword.shared.save(urlString: url, userDetails: data){ (success, error, result) in
                 if success {
                              let response = result!
                              let status = response.status
                              let message = response.message
                             
                       if (status == 200){
                        print("My Response:\(response)")
                           DispatchQueue.main.async {
                               self.removeSpinner()
                               self.performSegue(withIdentifier: "moveToLoginAfterPaswordReset", sender: self)
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
