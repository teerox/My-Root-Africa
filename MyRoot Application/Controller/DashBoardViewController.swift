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
    
    @IBOutlet weak var plantTrees: UIButton!
    
    
    @IBOutlet weak var logotBtn: UIBarButtonItem!
    
    
    var userName = ""
    var userEmail = ""
    var userToken = ""
    var userContry = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: false)
        time()
        fullName.text = userName
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(handleSignOut))
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
        
        
        if (dateTimeComponents.hour! >= 00 && dateTimeComponents.hour! < 12 ) {

            timeAndName.text = "Good Morning!"
            
        }else if (dateTimeComponents.hour! >= 12 && dateTimeComponents.hour! < 16 ) {

            timeAndName.text = "Good Afternoon!"
        }else{
            timeAndName.text = "Good Evening!"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "nextPage"{
                let vc = segue.destination as! WhereToPlantViewController
                   vc.userName = userName
                   vc.userEmail = userEmail
                   vc.userToken = userToken
                   vc.userContry = userContry
        }
   

        
     }
//
    override func viewDidAppear(_ animated: Bool) {
           // 1
          let nav = self.navigationController?.navigationBar

          // 2
          nav?.barStyle = UIBarStyle.black
          nav?.tintColor = UIColor.yellow
    }
    
    
    @IBAction func logOutButton(_ sender: UIBarButtonItem) {
//        performSegue(withIdentifier: "textMove", sender: self)
//        UserDefaults.standard.set(false, forKey: "loggedIn")
//        UserDefaults.standard.synchronize()
//        dismiss(animated: true, completion: nil)

                    self.loadLoginScreen()
                
    }
    
    func loadLoginScreen(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
        self.present(viewController, animated: true, completion: nil)
    }
    
//    func displayErrorMessage(message:String) {
//        let alertView = UIAlertController(title: "Error!", message: message, preferredStyle: .alert)
//        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
//        }
//        alertView.addAction(OKAction)
//        if let presenter = alertView.popoverPresentationController {
//            presenter.sourceView = self.view
//            presenter.sourceRect = self.view.bounds
//        }
//        self.present(alertView, animated: true, completion:nil)
//    }
    
}
