//
//  SignInViewController.swift
//  MyRoot Application
//
//  Created by macbook on 3/18/20.
//  Copyright © 2020 Decagon. All rights reserved.
//

import Foundation
import UIKit

class SignInViewController: UIViewController {
    

    @IBOutlet weak var loginPassword: UITextField!
    
    @IBOutlet weak var loginEmail: UITextField!
    var activeField: UITextField?
    
    let userManager = UserManager()
    var ApiData = Utility()
    var clientName = ""
    var clientEmail = ""
    var clientToken = ""
    var clientContry = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
      UserDefaults.standard.set(false, forKey: "loggedIn")
      UserDefaults.standard.synchronize()
       
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
    validate()
      
    }
    
    
    
    func validate(){
        self.showSpinner(onView: self.view)
        do {
            let userEmail = try loginEmail.validatedTexts(validationTypes: ValidatorType.email)
            let userPassword = try loginPassword.validatedTexts(validationTypes: ValidatorType.password)
            let endpoint = "user/login"
            let url = "\(ApiData.API)\(endpoint)"
             let data = Login(email: userEmail, password: userPassword)
            LoginRequest.shared.save(urlString: url, user: data){ (success, error, result) in
                if success {
                           let response = result!
                           let status = response.status
                           let message = response.message!
                         
                    if (status == 200){
                       
                        self.clientName = (response.payload?.name)!
                        self.clientEmail = (response.payload?.email)!
                        self.clientContry = (response.payload?.country)!
                        self.clientToken = response.token!
                        DispatchQueue.main.async {
                            self.removeSpinner()
                            UserDefaults.standard.set(true, forKey: "loggedIn")
                            UserDefaults.standard.synchronize()
                            self.performSegue(withIdentifier: "loginSuccessful", sender: self)
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
                    DispatchQueue.main.async {
                      self.showAlert(for: "Network Error...Please try Again")
                       self.removeSpinner()
                      }
                }
            }
        } catch(let error) {
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
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          
        if (segue.identifier == "loginSuccessful") {
             let vc = segue.destination as! DashBoardViewController
                   
                    vc.userName = clientName
                    vc.userEmail = clientEmail
                    vc.userToken = clientToken
                    vc.userContry = clientContry
        }
       
        
      }
    
}


//MARK: - UITextFieldDelegate
extension SignInViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeField = textField
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
}


//MARK: - UITextField


extension UITextField {
func validatedTexts(validationTypes: ValidatorType) throws -> String {
    let validator = VaildatorFactory.validatorFor(type: validationTypes)
    return try validator.validated(self.text!)
    }
}






