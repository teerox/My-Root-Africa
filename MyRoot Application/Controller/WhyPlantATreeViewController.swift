//
//  WhyPlantATreeViewController.swift
//  MyRoot Application
//
//  Created by macbook on 3/18/20.
//  Copyright © 2020 Decagon. All rights reserved.
//

import Foundation
import UIKit

class WhyPlantATreeViewController: UIViewController {
    
    var countrySelected = ""
    
    var first = ""
    var second = ""
    var third = ""
    
    var sendFirst = ""
    var sendSecond = ""
    var sendThird = ""
    
      var userName = ""
      var userEmail = ""
      var userToken = ""
      var userContry = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func checkBokeOneTapped(_ sender: UIButton) {
        if sender.isSelected{
            sender.isSelected = false
             first = ""
        }else{
            sender.isSelected = true
            first = "Climate action"
        }
    }
    
    @IBAction func checkBokTwoTapped(_ sender: UIButton) {
        if sender.isSelected{
                 sender.isSelected = false
            second = ""
             }else{
                 sender.isSelected = true
            second = "To create a job"
             }
    }
    
    
    
    @IBAction func checkBokThreeTapped(_ sender: UIButton) {
        if sender.isSelected{
                 sender.isSelected = false
            third = ""
             }else{
                 sender.isSelected = true
            third = "Gift"
             }
    }
    
    
    
    @IBAction func nextButton(_ sender: UIButton) {
        
        if (first == "" && second == "" && third == "") {
            showAlert(for: "Select atleast one")
        }else{
        
        if(first != ""){
            sendFirst = first
        }
        if(second != ""){
            sendSecond = second
        }
      
        if(third != ""){
            sendThird = third
        }
            
            performSegue(withIdentifier: "moveToTypeOfOccassion", sender: self)

        
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let vc = segue.destination as! TypeOfOccationViewController
        
        vc.firstRecieved = sendFirst
        vc.SecondRecieved = sendSecond
        vc.thirdRecieved = sendThird
        vc.country = countrySelected
        
        vc.userName = userName
       vc.userEmail = userEmail
       vc.userToken = userToken
       vc.userContry = userContry
    }
    
    func showAlert(for alert: String) {
        let alertController = UIAlertController(title: nil, message: alert, preferredStyle: UIAlertController.Style.alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
}
