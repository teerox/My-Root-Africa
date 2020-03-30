//
//  WhatTypeOfTreeViewController.swift
//  MyRoot Application
//
//  Created by macbook on 3/18/20.
//  Copyright © 2020 Decagon. All rights reserved.
//

import Foundation
import UIKit
import RxSwift


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
     //
    
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
    
    
    //inperson or remote->location
    var location = ""
    var occation = ""
    var reason = ""
  
    
    var whrToPlant = ""
    var isGift = false
    
    @IBOutlet weak var decorativeTreesOutlet: UIButton!
    
    @IBOutlet weak var fruitTreesOutlet: UIButton!
    
    @IBOutlet weak var environmentalTreesOutlet: UIButton!
    
    
    var disposedBag = DisposeBag()
    
    
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
                             fruitTree = ""
                             environmentalTree = ""
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
                        decorativeTree = ""
                       environmentalTree = ""
                       
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
         typeOfTrees()
        self.showSpinner(onView: self.view)
        if(gift != ""){
               isGift = true

               }
//        if(climateAction == "" && toCreateAjob == ""){
//        reason = "isGift"
//
//        }
//        if(gift == "" && toCreateAjob == ""){
//               reason = "climateAction"
//
//               }
//        
//        if(gift == "" && climateAction == ""){
//               reason = "toCreateAjob"
//
//               }
        
        if(remote == "") {
            location = "inPerson"
        }else{
            location = "Remote"
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
        
         if (country == "The Great Wall"){
            whrToPlant = "GGW"
         }else{
            whrToPlant = "54C"
        }
        
        let reason = Reason(isOccasion: false, isGift: isGift)
       
    let tree = Tree(name: userName, email: userEmail, picture: "", treeType: typeOfTree, locationType: whrToPlant, reason: reason, occasion: occation, date: date, country: userContry, location: location, longitude: "", latitude: "", token: userToken, new: true)
        

        guard let token = tree.token else {
               fatalError("Invalid authorization")
           }

        
        let endpoint = "tree"
        let url = "\(ApiData.API)\(endpoint)"

        SaveData.shared.reserveTree(urlString: url, tree: tree, token: token).subscribe(onNext:{(AllUserInput) in
           // print("messaage \(String(describing: AllUserInput.message))")
            self.showSpinner(onView: self.view)
            if AllUserInput.status == 200{
               //  print("messaagesss: \(AllUserInput))")
                self.performSegue(withIdentifier: "moveTodashBoard", sender: self)
                self.showAlert(for: AllUserInput.message!)
                //perform segue
                
            }else{
                self.showAlert(for: AllUserInput.message!)
            }
            
        },onError: { (Error) in
            //self.progressSpinner.isHidden = true
           // self.submitButton.isHidden = false
            print("Error: \(String(describing: Error.asAFError))")
            print("Errorcode: \(String(describing: Error.asAFError?.responseCode))")
        }, onCompleted: {
            print("completed")
        }, onDisposed: {
            print("disposed")
        }).disposed(by: disposedBag)
        
    }
        
}
