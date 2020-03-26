//
//  DashBoardViewController.swift
//  MyRoot Application
//
//  Created by macbook on 3/18/20.
//  Copyright © 2020 Decagon. All rights reserved.
//

import Foundation
import UIKit

class DashBoardViewController: UIViewController {
    
    @IBOutlet weak var timeAndName: UILabel!
    
    @IBOutlet weak var fullName: UILabel!
    
    var userName = ""
    var userEmail = ""
    var userToken = ""
    var userContry = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: false)
        time()
        fullName.text = userName
    }

    func time(){
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
        
        
       // let time = "\(dateTimeComponents.hour!):\(dateTimeComponents.minute!)"
        
        
        if (dateTimeComponents.hour! == 00 && dateTimeComponents.hour! < 12 ) {

            timeAndName.text = "Good Morning!"
            
        }else if (dateTimeComponents.hour! >= 12 && dateTimeComponents.hour! < 16 ) {

            timeAndName.text = "Good Afternoon!"
        }else{
            timeAndName.text = "Good Evening!"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         
         let vc = segue.destination as! WhereToPlantViewController
        vc.userName = userName
        vc.userEmail = userEmail
        vc.userToken = userToken
        vc.userContry = userContry
        
     }
    
    
}
