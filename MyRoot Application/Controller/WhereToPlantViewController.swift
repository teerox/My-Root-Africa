//
//  WhereToPlantViewController.swift
//  MyRoot Application
//
//  Created by macbook on 3/18/20.
//  Copyright © 2020 Decagon. All rights reserved.
//

import Foundation
import UIKit
import iOSDropDown

class WhereToPlantViewController: UIViewController {
    
    @IBOutlet weak var the54Countries: UIButton!
    
    
    @IBOutlet weak var theGreatWall: UIButton!
    
    
    
    @IBOutlet weak var listOfAfricanCountries: DropDown!
    
    var whereToPlant = ""
    
    let listOfCountries = Country().getAfricanCountries()
    
    
    var userName = ""
    var userEmail = ""
    var userToken = ""
    var userContry = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listOfAfricanCountries.optionArray = listOfCountries.sorted()
        listOfAfricanCountries.delegate  = self as? UITextFieldDelegate
        listOfAfricanCountries.isUserInteractionEnabled = false
        listOfAfricanCountries.placeholder = "Disabled       "
        
    }
    
    
    @IBAction func firstStackViewButton(_ sender: UIButton) {
        
        if sender.isSelected{
            sender.isSelected = false
            whereToPlant = ""
            listOfAfricanCountries.isUserInteractionEnabled = false
            listOfAfricanCountries.placeholder = "Disabled       "
            sender.layer.cornerRadius = 0
            sender.layer.borderWidth = 0
            
        }else{
            sender.layer.borderColor =  UIColor.green.cgColor
            sender.layer.cornerRadius = 8.0
            sender.layer.borderWidth = 1.0
            sender.isSelected = true
            theGreatWall.layer.cornerRadius = 0
            theGreatWall.layer.borderWidth = 0
            listOfAfricanCountries.isUserInteractionEnabled = true
            listOfAfricanCountries.placeholder = "Select Country"
            
            theGreatWall.isSelected = false
        }
        
    }
    
    
    @IBAction func secondStackViewButton(_ sender: UIButton) {
        if sender.isSelected{
            sender.isSelected = false
            whereToPlant = ""
            sender.layer.cornerRadius = 0
            sender.layer.borderWidth = 0
        }else{
            sender.isSelected = true
            sender.layer.borderColor =  UIColor.green.cgColor
            sender.layer.cornerRadius = 8.0
            sender.layer.borderWidth = 1.0
            listOfAfricanCountries.isUserInteractionEnabled = false
            listOfAfricanCountries.placeholder = "Disabled       "
            //listOfAfricanCountries.isHidden = true
            // textField.isUserInteractionEnabled = false
            the54Countries.layer.cornerRadius = 0
            the54Countries.layer.borderWidth = 0
            whereToPlant = "The Great Wall"
            the54Countries.isSelected = false
        }
    }
    
    
    
    @IBAction func nextButton(_ sender: UIButton) {
        if(whereToPlant == "The Great Wall"){
            performSegue(withIdentifier: "moveToWhyPlant", sender: self)
        }else{
            validate()
        }
    }
    
    
    func validate(){
        do {
            let countrySelected = try self.listOfAfricanCountries.validatedText(validationType: ValidatorType.country)
            whereToPlant = countrySelected
            performSegue(withIdentifier: "moveToWhyPlant", sender: self)
            
        } catch(let error) {
            showAlert(for: (error as! ValidationError).message)
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! WhyPlantATreeViewController
        vc.countrySelected = whereToPlant
        
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



