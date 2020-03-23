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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginEmail.delegate = self
        loginPassword.delegate = self
       
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        if(validate()){
            
        }
    }
    
    
    
    func validate()->Bool {
        self.showSpinner(onView: self.view)
        do {
            let userEmail = try loginEmail.validatedTexts(validationTypes: ValidatorType.email)
            let userPassword = try loginPassword.validatedTexts(validationTypes: ValidatorType.password)
            let data = Login(email: userEmail, password: userPassword)
            userManager.login(userData: data)
            showAlert(for: "Login Successful")
            return true
        } catch(let error) {
            showAlert(for: (error as! ValidationError).message)
            return false
        }
    }
    
    
    
    
    func showAlert(for alert: String) {
        let alertController = UIAlertController(title: nil, message: alert, preferredStyle: UIAlertController.Style.alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
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






