//
//  SignUpViewController.swift
//  MyRoot Application
//
//  Created by macbook on 3/18/20.
//  Copyright © 2020 Decagon. All rights reserved.
//

import Foundation
import UIKit
import iOSDropDown


class SignUpViewController: UIViewController{
    
    
    var activeField: UITextField?
    
    @IBOutlet weak var fullName: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var countryList: DropDown!
    
    @IBOutlet weak var phoneNumber: UITextField!
    
    var userManger = UserManager()
    
    let listOfCountries = Country().getCountries()
    var ApiData = Utility()
    
    var tokenPassed = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fullName.delegate = self
        password.delegate = self
        email.delegate  = self
        
        countryList.optionArray = listOfCountries.sorted()
    }
    
    
    @IBAction func signUpBotton(_ sender: UIButton) {
        //performSegue(withIdentifier: "moveToverification", sender: self)
        validate()
    }
    
    
    
    func validate(){
        self.showSpinner(onView: self.view)
        do {
            let userEmail = try self.email.validatedText(validationType: ValidatorType.email)
            let userFullName = try self.fullName.validatedText(validationType: ValidatorType.fullname)
            let userPhoneNumber = try self.phoneNumber.validatedText(validationType: ValidatorType.phone)
            let userPassword = try self.password.validatedText(validationType: ValidatorType.password)
            let userCountry = try self.countryList.validatedText(validationType: ValidatorType.country)
            let data = RegisterData(name: userFullName, email: userEmail, password: userPassword, country: userCountry, phone: userPhoneNumber)
            let endPoint = "user"
            let url = "\(ApiData.API)\(endPoint)"
            
            SignUpApiRequest.shared.postRequestFunction(urlString: url, user: data){ (success, error, result) in
                if success {
                    let response = result!
                    let status = response["status"] as! Int
                    let message = response["message"] as! String
                    
                    if (status == 200) {
                        let token = response["token"] as? String
                        DispatchQueue.main.async {
                      
                            self.tokenPassed = token ?? ""
                            self.removeSpinner()
                            self.performSegue(withIdentifier: "moveToverification", sender: self)
                            self.showAlert(for: message)
                            
                            //pass this token to the next view controller
                            self.tokenPassed = token ?? ""
                        }
                    }else{
                        DispatchQueue.main.async {
                            self.showAlert(for: message)
                            self.removeSpinner()
                        }
                    }
                } else {
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
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "moveToverification") {
            let vc = segue.destination as! VerificationViewController
            vc.userToken = tokenPassed
        }
  }
    
    
    func showAlert(for alert: String) {
        let alertController = UIAlertController(title: nil, message: alert, preferredStyle: UIAlertController.Style.alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func res(respon:ResponseGiven){
        print("My Message:\(respon.message)")
    }
    
}


//MARK: - UITextFieldDelegate

extension SignUpViewController : UITextFieldDelegate{
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeField = textField
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
}


//MARK: - UITextField


extension UITextField {
    func validatedText(validationType: ValidatorType) throws -> String {
        let validator = VaildatorFactory.validatorFor(type: validationType)
        return try validator.validated(self.text!)
    }
}


 var vSpinner : UIView?
extension UIViewController {
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init()
        ai.startAnimating()
        ai.center = spinnerView.center

        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }

        vSpinner = spinnerView
    }

    func removeSpinner() {
        DispatchQueue.main.async {
            vSpinner?.removeFromSuperview()
            vSpinner = nil
        }
    }
}




