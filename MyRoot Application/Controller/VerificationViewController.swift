//
//  VerificationViewController.swift
//  MyRoot Application
//
//  Created by macbook on 3/18/20.
//  Copyright © 2020 Decagon. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class VerificationViewController: UIViewController{
    

    
    @IBOutlet weak var textOne: UITextField!
    
    @IBOutlet weak var textTwo: UITextField!
    
    @IBOutlet weak var textThree: UITextField!
    
    @IBOutlet weak var textFour: UITextField!
    
    var validate = Utility()
    var authorise = UserManager()
    var userToken2:String?
    var userToken = ""
    var ApiData = Utility()
   

    var userMessage:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textOne.delegate = self
        textTwo.delegate = self
        textThree.delegate = self
        textFour.delegate = self
        textOne.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        textTwo.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        textThree.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        textFour.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        print("Check Tok\(userToken)")
      
    }
    
    
    
    @IBAction func submitOTP(_ sender: UIButton) {
        textFieldvalidate()
      
    }
    

    func textFieldvalidate(){
        self.showSpinner(onView: self.view)
        if(validate.validate(input: textOne.text!) && validate.validate(input: textTwo.text!) && validate.validate(input: textThree.text!) && validate.validate(input: textFour.text!)){
              let OTP = textOne.text! + textTwo.text! + textThree.text! + textFour.text!
           
          
            let code = ["code" : OTP]

            let endPoint = "auth/verify"
            let url = "\(ApiData.API)\(endPoint)"

           AuthApiRequest.shared.getApi(urlString: url, code: code, token: userToken){ (success, error, result) in
               if success {
                   let response = result!
                   let status = response.status!
                   let message = response.message!
                   print("Finally Done:\(response)")
                   if (status == 200) {
                       _ = response.payload!
                   DispatchQueue.main.async {
                    self.removeSpinner()
                   self.performSegue(withIdentifier: "verificationSucessful", sender: self)
                   self.showAlert(for: message)
                     
                       
                   }
               }else{
                   DispatchQueue.main.async {
                   self.showAlert(for: message)
                    self.removeSpinner()
                   }
               }
                       } else {
               print("Failed ahh")
                       }
               
              //performSegue(withIdentifier: "verificationSucessful", sender: self)
               }
           }else{
            showAlert(for: "Field is Empty")
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

extension VerificationViewController : UITextFieldDelegate {
    
    @objc func textFieldDidChange(textField: UITextField){
           let text = textField.text
           if  text?.count == 1 {
               switch textField{
               case textOne:
                   textTwo.becomeFirstResponder()
               case textTwo:
                   textThree.becomeFirstResponder()
               case textThree:
                   textFour.becomeFirstResponder()
               case textFour:
                   textFour.resignFirstResponder()
               default:
                   break
               }
           }
           if  text?.count == 0 {
               switch textField{
               case textOne:
                   textTwo.becomeFirstResponder()
               case textTwo:
                   textOne.becomeFirstResponder()
               case textThree:
                   textTwo.becomeFirstResponder()
               case textFour:
                   textThree.becomeFirstResponder()
               default:
                   break
               }
           }
           else{

           }
       }
    
}








