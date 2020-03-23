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
    
      var birthDayRecieved = ""
      var aniversaryRecieved = ""
      var holidaysRecieved = ""
      var othersRecieved = ""
      
      var climateAction = ""
      var toCreateAjob = ""
      var gift = ""
      var country = ""
      
      
      var remote = ""
      var inPerson = ""
    
    
      var decorativeTree = ""
      var fruitTree = ""
      var environmentalTree = ""
      var sendDecorativeTree = ""
      var sendFruitTree = ""
      var sendEnvironmentalTree = ""
      
        
    
  
      
    
    @IBOutlet weak var decorativeTreesOutlet: UIButton!
    
    @IBOutlet weak var fruitTreesOutlet: UIButton!
    
    @IBOutlet weak var environmentalTreesOutlet: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
            print("B:\(birthDayRecieved)")
            print("A:\(aniversaryRecieved)")
            print("H:\(holidaysRecieved)")
            print("O:\(othersRecieved)")
            print("C:\(climateAction)")
            print("T:\(toCreateAjob)")
            print("G:\(gift)")
            print("C:\(country)")
            print("R:\(remote)")
            print("I:\(inPerson)")
        
    
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
        
        
        
                if (environmentalTree == "" && fruitTree == "" && decorativeTree == "") {
                       showAlert(for: "Select one")
                }else if(environmentalTree != "" && fruitTree == "" && decorativeTree == ""){
                      sendEnvironmentalTree = environmentalTree
                     let allData = fullData(birthDayRecieved: birthDayRecieved, aniversaryRecieved: aniversaryRecieved, holidaysRecieved: holidaysRecieved, othersRecieved: othersRecieved, climateAction: climateAction, toCreateAjob: toCreateAjob, gift: gift, country: country, remote: remote, inPerson: inPerson, sendDecorativeTree: sendDecorativeTree, sendFruitTree: sendFruitTree, sendEnvironmentalTree: sendEnvironmentalTree)
                      print("DataToSave:\(allData)")
                      
                      performSegue(withIdentifier: "moveTodashBoard", sender: self)
                    
                }else if(environmentalTree == "" && fruitTree != "" && decorativeTree == ""){
                     sendFruitTree = fruitTree
                      let allData = fullData(birthDayRecieved: birthDayRecieved, aniversaryRecieved: aniversaryRecieved, holidaysRecieved: holidaysRecieved, othersRecieved: othersRecieved, climateAction: climateAction, toCreateAjob: toCreateAjob, gift: gift, country: country, remote: remote, inPerson: inPerson, sendDecorativeTree: sendDecorativeTree, sendFruitTree: sendFruitTree, sendEnvironmentalTree: sendEnvironmentalTree)
                    
                      print("DataToSave:\(allData)")
                      
                      performSegue(withIdentifier: "moveTodashBoard", sender: self)
                  
                }else if(environmentalTree == "" && fruitTree == "" && decorativeTree != ""){
                     sendDecorativeTree = decorativeTree
                    
                      let allData = fullData(birthDayRecieved: birthDayRecieved, aniversaryRecieved: aniversaryRecieved, holidaysRecieved: holidaysRecieved, othersRecieved: othersRecieved, climateAction: climateAction, toCreateAjob: toCreateAjob, gift: gift, country: country, remote: remote, inPerson: inPerson, sendDecorativeTree: sendDecorativeTree, sendFruitTree: sendFruitTree, sendEnvironmentalTree: sendEnvironmentalTree)
                    
                      print("DataToSave:\(allData)")
                      
                      performSegue(withIdentifier: "moveTodashBoard", sender: self)
                }
        
  
    }
    
    func showAlert(for alert: String) {
           let alertController = UIAlertController(title: nil, message: alert, preferredStyle: UIAlertController.Style.alert)
           let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
           alertController.addAction(alertAction)
           present(alertController, animated: true, completion: nil)
       }
}
