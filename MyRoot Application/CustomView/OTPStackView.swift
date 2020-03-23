////
////  OTPStackView.swift
////  MyRoot Application
////
////  Created by macbook on 3/19/20.
////  Copyright © 2020 Decagon. All rights reserved.
////
//
//import Foundation
//import UIKit
//
////Colors
//let inactiveFieldBorderColor = UIColor(white: 1, alpha: 0.3)
//let textBackgroundColor = UIColor(white: 1, alpha: 0.5)
//let activeFieldBorderColor = UIColor.white
//
//class OTPStackView: UIViewController  {
//    
//    //Customise the OTPField here
//    let numberOfFields = 4
//    var textFieldsCollection: [OTPTextField] = []
//    weak var delegate: OTPDelegate?
//    var showsWarningColor = false
//    
//
//    //checks if all the OTPfields are filled
//    func checkForValidity(){
//        for fields in textFieldsCollection{
//            if (fields.text == ""){
//                delegate?.didChangeValidity(isValid: false)
//                return
//            }
//        }
//        delegate?.didChangeValidity(isValid: true)
//    }
//    
//    //gives the OTP text
//    func getOTP() -> String {
//        var OTP = ""
//        for textField in textFieldsCollection{
//            OTP += textField.text ?? ""
//        }
//        return OTP
//    }
//
//    //set isWarningColor true for using it as a warning color
//    func setAllFieldColor(isWarningColor: Bool = false, color: UIColor){
//        for textField in textFieldsCollection{
//            textField.layer.borderColor = color.cgColor
//        }
//        showsWarningColor = isWarningColor
//    }
//    
//}
//
////TextField related operations
//extension OTPStackView: UITextFieldDelegate {
//    
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        if showsWarningColor {
//            setAllFieldColor(color: inactiveFieldBorderColor)
//            showsWarningColor = false
//        }
//        textField.layer.borderColor = activeFieldBorderColor.cgColor
//    }
//    
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        textField.layer.borderColor = inactiveFieldBorderColor.cgColor
//    }
//    
//    //switches between OTPTextfields
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range:NSRange, replacementString string: String) -> Bool {
//        
//        guard let textField = textField as? OTPTextField else { return true }
//        
//        if (range.length == 0){
//            
//            if textField.nextTextField == nil {
//                textField.resignFirstResponder()
//            }else{
//                textField.nextTextField?.becomeFirstResponder()
//            }
//            textField.text? = string
//            checkForValidity()
//            return false
//            
//        }
//        else if (range.length == 1) {
//            
//            textField.previousTextField?.becomeFirstResponder()
//            textField.text? = ""
//            checkForValidity()
//            return false
//            
//        }
//        return true
//    }
//    
//}
//
//
//protocol OTPDelegate: class {
//    //always triggers when the OTP field is valid
//    func didChangeValidity(isValid: Bool)
//}
//
//extension ViewController: OTPDelegate {
//    
//    func didChangeValidity(isValid: Bool) {
//        testButton.isHidden = !isValid
//    }
//    
//}
