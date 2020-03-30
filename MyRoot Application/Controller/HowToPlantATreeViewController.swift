//
//  HowToPlantATreeViewController.swift
//  MyRoot Application
//
//  Created by macbook on 3/18/20.
//  Copyright © 2020 Decagon. All rights reserved.
//

import Foundation
import UIKit

class HowToPlantAViewController: UIViewController {
    
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
    var sendRemote = ""
    var sendInPerson = ""
    
    
    var userName = ""
    var userEmail = ""
    var userToken = ""
    var userContry = ""

    @IBOutlet weak var remoteButtonoutlet: UIButton!
    
    @IBOutlet weak var inPersonButtonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func remoteButton(_ sender: UIButton) {
        
        if sender.isSelected{
                   sender.isSelected = false
                    remote = ""
               }else{
                   sender.isSelected = true
                   remote = "Remote"
            inPerson = ""
            inPersonButtonOutlet.isSelected = false
               }
    }
    
    @IBAction func inPersonButton(_ sender: UIButton) {
        if sender.isSelected{
                   sender.isSelected = false
                    inPerson = ""
               }else{
                   sender.isSelected = true
                   inPerson = "InPerson"
                    remote = ""
            remoteButtonoutlet.isSelected = false
               }
    }
    

    @IBAction func nextButton(_ sender: UIButton) {
        
        if (remote == "" && inPerson == "") {
                 showAlert(for: "Select one")
             }else if(remote != "" && inPerson == ""){
                   sendRemote = remote
                  performSegue(withIdentifier: "whatTypeOfTree", sender: self)
             }else if(remote == "" && inPerson != ""){
                  sendInPerson = inPerson
                  performSegue(withIdentifier: "whatTypeOfTree", sender: self)
             }
        
        
        
    }
    
    func showAlert(for alert: String) {
         let alertController = UIAlertController(title: nil, message: alert, preferredStyle: UIAlertController.Style.alert)
         let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
         alertController.addAction(alertAction)
         present(alertController, animated: true, completion: nil)
     }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let vc = segue.destination as! WhatTypeOfTreeViewController
        vc.aniversaryRecieved = aniversaryRecieved
        vc.birthDayRecieved = birthDayRecieved
        vc.climateAction = climateAction
        vc.country = country
        vc.gift = gift
        vc.holidaysRecieved = holidaysRecieved
        vc.inPerson = inPerson
        vc.remote = remote
        vc.toCreateAjob = toCreateAjob
        vc.othersRecieved = othersRecieved
        vc.userName = userName
        vc.userEmail = userEmail
        vc.userToken = userToken
        vc.userContry = userContry
    }
    

    
}
