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
        
    }
    

    @IBAction func firstStackViewButton(_ sender: UIButton) {
//        firstStackViewSelect.addBackground(color: .gray)
//        secondStackViewSelect.addBackground(color: .white)
    }


    @IBAction func secondStackViewButton(_ sender: UIButton) {
//        firstStackViewSelect.addBackground(color: .white)
//        secondStackViewSelect.addBackground(color: .gray)
    }
    
    
    
    @IBAction func nextButton(_ sender: UIButton) {
        if(validate()){
            performSegue(withIdentifier: "moveToWhyPlant", sender: self)
        }
    }
    
    
    func validate()->Bool{
        do {
            let countrySelected = try self.listOfAfricanCountries.validatedText(validationType: ValidatorType.country)
            whereToPlant = countrySelected
            print(whereToPlant)
            return true
    } catch(let error) {
               showAlert(for: (error as! ValidationError).message)
               return false
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



