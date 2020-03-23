//
//  OTPTextField.swift
//  MyRoot Application
//
//  Created by macbook on 3/19/20.
//  Copyright © 2020 Decagon. All rights reserved.
//

import Foundation
import UIKit

class OTPTextField: UITextField {
  weak var previousTextField: OTPTextField?
  weak var nextTextField: OTPTextField?
  override public func deleteBackward(){
  if text == "" {
    previousTextField?.becomeFirstResponder()
   }
  }
}
