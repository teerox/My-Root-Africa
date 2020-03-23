//
//  SettingsViewController.swift
//  MyRoot Application
//
//  Created by macbook on 3/18/20.
//  Copyright © 2020 Decagon. All rights reserved.
//

import Foundation
import UIKit
import iOSDropDown

class SettingsViewController: UIViewController {
    
     let listOfCountries = Country().getCountries()
    
    @IBOutlet weak var countryList: DropDown!
    override func viewDidLoad() {
        super.viewDidLoad()
        countryList.optionArray = listOfCountries.sorted()
    }
}
