//
//  SignInViewController.swift
//  MyRoot Application
//
//  Created by macbook on 3/18/20.
//  Copyright © 2020 Decagon. All rights reserved.
//

import Foundation
import UIKit
import iProgressHUD


protocol MyDataSendingDelegateProtocol {
    func sendDataToFirstViewController(myData: SendData)
}

class SignInViewController: UIViewController {
    
    var delegate: MyDataSendingDelegateProtocol?
    
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
        // self.showSpinner(onView: self.view)
        // Attach iProgressHUD to views
        iProgressHUD.sharedInstance().attachProgress(toView: self.view)
        // Show iProgressHUD directly from view
        view.showProgress()
        
        
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
                        print("UserToks:\(response.token!)")
                        UserDefaults.standard.set((response.payload?.name)!, forKey: "name")
                        UserDefaults.standard.set((response.payload?.email)!, forKey: "email")
                        UserDefaults.standard.set((response.payload?.country)!, forKey: "country")
                        UserDefaults.standard.set(response.token!, forKey: "token")
                        
                        //
                        
                        
                        
                        let all = SendData(name: (response.payload?.name)!, email: (response.payload?.email)!, token: response.token!, country: (response.payload?.country)!)
                        
                        let dataToBeSent = all
                        self.delegate?.sendDataToFirstViewController(myData: dataToBeSent)
                        
                        
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
                            //self.removeSpinner()
                            self.view.dismissProgress()
                        }
                    }
                    
                }else{
                    print(error!)
                    DispatchQueue.main.async {
                        self.showAlert(for: "Network Error...Please try Again")
                        //self.removeSpinner()
                        self.view.dismissProgress()
                    }
                }
            }
        } catch(let error) {
            showAlert(for: (error as! ValidationError).message)
            //self.removeSpinner()
            self.view.dismissProgress()
        }
    }
    
    
    
    func showAlert(for alert: String) {
        let alertController = UIAlertController(title: nil, message: alert, preferredStyle: UIAlertController.Style.alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    
    
    
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //
    ////        if (segue.identifier == "loginSuccessful") {
    ////             let vc = segue.destination as! DashBoardViewController
    ////
    ////                    vc.userName = clientName
    ////                    vc.userEmail = clientEmail
    ////                    vc.userToken = clientToken
    ////                    vc.userContry = clientContry
    ////        }
    //
    //
    //      }
    
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






