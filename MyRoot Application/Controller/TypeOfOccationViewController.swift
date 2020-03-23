//
//  TypeOfOccationViewController.swift
//  MyRoot Application
//
//  Created by macbook on 3/18/20.
//  Copyright © 2020 Decagon. All rights reserved.
//

import Foundation
import UIKit

class TypeOfOccationViewController: UIViewController {
    
    
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var firstButton: UIButton!
    
    @IBOutlet weak var seconButton: UIButton!
    
    @IBOutlet weak var thirdButton: UIButton!
    
    @IBOutlet weak var fourthButton: UIButton!
    
    
    var firstRecieved = ""
    var SecondRecieved = ""
    var thirdRecieved = ""
    var country = ""
    
    
    var birthDay = ""
    var anniversary = ""
    var holidays = ""
    var others = ""
    
    var sendBirthday = ""
    var sendAnniversary = ""
    var sendHolidays = ""
    var sendOthers = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(firstRecieved)
        print(SecondRecieved)
        print(thirdRecieved)
        print(country)
        
    }
    @IBAction func nextButton(_ sender: UIButton) {
        
        if (birthDay == "" && anniversary == "" && holidays == "" && others == "") {
            showAlert(for: "Select one")
        }else if(birthDay != "" && anniversary == "" && holidays == "" && others == ""){
             sendBirthday = birthDay
             performSegue(withIdentifier: "howToPlant", sender: self)
        }else if(birthDay == "" && anniversary != "" && holidays == "" && others == ""){
            
             sendAnniversary = anniversary
             performSegue(withIdentifier: "howToPlant", sender: self)
        }else if(birthDay == "" && anniversary == "" && holidays != "" && others == ""){
            
             sendHolidays = holidays
             performSegue(withIdentifier: "howToPlant", sender: self)
        }else if(birthDay == "" && anniversary == "" && holidays == "" && others != ""){
            
             sendOthers = others
             performSegue(withIdentifier: "howToPlant", sender: self)
        }
    }
    
    
    
    @IBAction func birthdatButon(_ sender: UIButton) {
        if sender.isSelected{
               sender.isSelected = false
            birthDay = ""
           }else{
               sender.isSelected = true
            birthDay = "birthday"
            anniversary = ""
            others = ""
            holidays = ""
            seconButton.isSelected = false
            thirdButton.isSelected = false
            fourthButton.isSelected = false
            
           }
    }
    
    @IBAction func anniveraryButton(_ sender: UIButton) {
        if sender.isSelected{
              sender.isSelected = false
             anniversary = ""
          }else{
              sender.isSelected = true
            anniversary = "anniversary"
            birthDay = ""
            others = ""
            holidays = ""
        firstButton.isSelected = false
       thirdButton.isSelected = false
       fourthButton.isSelected = false
        
          }
    }
    
    
    
    
    @IBAction func holidayButton(_ sender: UIButton) {
        if sender.isSelected{
               sender.isSelected = false
                 holidays = ""
           }else{
               sender.isSelected = true
                holidays = "holidays"
                birthDay = ""
                anniversary = ""
                others = ""
                seconButton.isSelected = false
               firstButton.isSelected = false
               fourthButton.isSelected = false
         
           }
    }
    
    
    
    
    @IBAction func othersButton(_ sender: UIButton) {
        if sender.isSelected{
           sender.isSelected = false
           others = ""
       }else{
           sender.isSelected = true
            others = "others"
            holidays = ""
            birthDay = ""
            anniversary = ""
            seconButton.isSelected = false
             firstButton.isSelected = false
             thirdButton.isSelected = false
       }
    }
    
    
    
    func showAlert(for alert: String) {
          let alertController = UIAlertController(title: nil, message: alert, preferredStyle: UIAlertController.Style.alert)
          let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
          alertController.addAction(alertAction)
          present(alertController, animated: true, completion: nil)
      }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let vc = segue.destination as! HowToPlantAViewController
            vc.birthDayRecieved = sendBirthday
            vc.aniversaryRecieved = sendAnniversary
            vc.holidaysRecieved = sendHolidays
            vc.othersRecieved = sendOthers
            vc.climateAction = firstRecieved
            vc.toCreateAjob = SecondRecieved
            vc.gift = thirdRecieved
            vc.country = country
    }
    
}
