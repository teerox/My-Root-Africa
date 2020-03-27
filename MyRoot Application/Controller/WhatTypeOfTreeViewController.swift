//
//  WhatTypeOfTreeViewController.swift
//  MyRoot Application
//
//  Created by macbook on 3/18/20.
//  Copyright © 2020 Decagon. All rights reserved.
//

import Foundation
import UIKit

class WhatTypeOfTreeViewController: UIViewController {
    
     var ApiData = Utility()
     //Type of Occasion
      var birthDayRecieved = ""
      var aniversaryRecieved = ""
      var holidaysRecieved = ""
      var othersRecieved = ""
      
    
      //Why plant a tree
      var climateAction = ""
      var toCreateAjob = ""
      var gift = ""
    
    
      var country = ""
      
      //How to plant
      var remote = ""
      var inPerson = ""
    
    
      var decorativeTree = ""
      var fruitTree = ""
      var environmentalTree = ""
    
    
      //Why Plant
      var sendDecorativeTree = ""
      var sendFruitTree = ""
      var sendEnvironmentalTree = ""
      var typeOfTree = ""
      
    
    var userName = ""
    var userEmail = ""
    var userToken = ""
    var userContry = ""
    var date = ""
    var locationType = ""
    var location = ""
    var occation = ""
    var isGift = false
  
      
    
    @IBOutlet weak var decorativeTreesOutlet: UIButton!
    
    @IBOutlet weak var fruitTreesOutlet: UIButton!
    
    @IBOutlet weak var environmentalTreesOutlet: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            date = time()
    }
    
    
    @IBAction func decorativeButton(_ sender: UIButton) {
        if sender.isSelected{
                          sender.isSelected = false
                           decorativeTree = ""
                      }else{
                          sender.isSelected = true
                          decorativeTree = "Decorative Trees"
                       
            fruitTreesOutlet.isSelected = false
            environmentalTreesOutlet.isSelected = false
                      }
        
    }
    
    @IBAction func fruitTrees(_ sender: UIButton) {
        if sender.isSelected{
                          sender.isSelected = false
                           fruitTree = ""
                      }else{
                          sender.isSelected = true
                          fruitTree = "Fruit Trees"
                       
                      decorativeTreesOutlet.isSelected = false
                       environmentalTreesOutlet.isSelected = false
                      }
        
    }
    
    
    
    @IBAction func environmentalButton(_ sender: UIButton) {
        
        if sender.isSelected{
                          sender.isSelected = false
                           environmentalTree = ""
                      }else{
                          sender.isSelected = true
                          environmentalTree = "Environmental Trees"
                         
                          decorativeTreesOutlet.isSelected = false
                          fruitTreesOutlet.isSelected = false
                      }
        
        
    }
    
    
    @IBAction func submitButton(_ sender: UIButton) {
        typeOfTrees()
        saveAll()
            
    }
    
    // performSegue(withIdentifier: "moveTodashBoard", sender: self)
    
    func showAlert(for alert: String) {
           let alertController = UIAlertController(title: nil, message: alert, preferredStyle: UIAlertController.Style.alert)
           let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
           alertController.addAction(alertAction)
           present(alertController, animated: true, completion: nil)
       }
    
    
    func time()->String {
        // get the current date and time
        let currentDateTime = Date()

        // get the user's calendar
        let userCalendar = Calendar.current

        // choose which date and time components are needed
        let requestedComponents: Set<Calendar.Component> = [
            .year,
            .month,
            .day,
            .hour,
            .minute,
            .second
        ]
        // get the components
        let dateTimeComponents = userCalendar.dateComponents(requestedComponents, from: currentDateTime)
        
        
        let year = dateTimeComponents.year
        let month = dateTimeComponents.month
        let day = dateTimeComponents.day
        
        let date = "\(day!)-\(month!)-\(year!)"
        
        return date
    }
    
    
    func typeOfTrees(){
        if (environmentalTree == "" && fruitTree == "" && decorativeTree == "") {
                           showAlert(for: "Select one")
                    }else if(environmentalTree != "" && fruitTree == "" && decorativeTree == ""){
                          sendEnvironmentalTree = environmentalTree
                          typeOfTree = environmentalTree
                  
                    }else if(environmentalTree == "" && fruitTree != "" && decorativeTree == ""){
                         sendFruitTree = fruitTree
                         typeOfTree = fruitTree
                      
                    }else if(environmentalTree == "" && fruitTree == "" && decorativeTree != ""){
                         sendDecorativeTree = decorativeTree
                        typeOfTree = decorativeTree
                    }
    }
    
    
    
    func  saveAll(){
        self.showSpinner(onView: self.view)
        if(gift != ""){
        isGift = true

        }
        if(remote == "") {
            locationType = "inPerson"
        }else{
            locationType = "Remote"
        }
        
        if(birthDayRecieved == "" && aniversaryRecieved == "" && othersRecieved == "") {
            occation = "HolidayRecieved"
        }else if(birthDayRecieved == "" && aniversaryRecieved == "" && holidaysRecieved == "") {
            occation = "Others"
        }else if(othersRecieved == "" && aniversaryRecieved == "" && holidaysRecieved == "") {
            occation = "BirthDay"
        }else{
             occation = "Anniversary"
        }

        let reason = Reason(isOcassion: false, isGift: isGift)
        
        let dataToSave = CompleteData(email: userEmail, name: userName, picture: "", treeType: typeOfTree, locationType: locationType, reason: reason, occassion: occation, date: date, country: userContry, location: country, longitude: "", latitude: "")
        print(dataToSave)
        let endpoint = "tree"
        let url = "\(ApiData.API)\(endpoint)"
        print(url)
        SaveData.shared.save(urlString: url, token: userToken, completeData:dataToSave){
            (success, error, result) in
            if success {
                         let response = result!
                         let status = response.status
                         let message = response.message
                let data = response.payload
                        
                  if (status == 200){
                   print("My Response:\(response)")
                      DispatchQueue.main.async {
                        print("theEnd:\(data)")
                          self.removeSpinner()
                          self.performSegue(withIdentifier: "moveTodashBoard", sender: self)
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
    }
}
