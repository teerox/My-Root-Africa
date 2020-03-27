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
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        time()
        
        userName = UserDefaults.standard.string(forKey: "name")!
        userEmail = UserDefaults.standard.string(forKey: "email")!
        userContry = UserDefaults.standard.string(forKey: "country")!
        userToken = UserDefaults.standard.string(forKey: "token")!
        fullName.text = userName
    }
  

    func time(){
        // get the current date and time
        let currentDateTime = Date()

        // get the user's calendar
        let userCalendar = Calendar.current

        // choose which date and time components are needed
        let requestedComponents: Set<Calendar.Component> = [
            .year,.month,.day,.hour,.minute,.second]
        // get the components
        let dateTimeComponents = userCalendar.dateComponents(requestedComponents, from: currentDateTime)
        if (dateTimeComponents.hour! >= 00 && dateTimeComponents.hour! < 12 ) {

            timeAndName.text = "Good Morning"

        }else if (dateTimeComponents.hour! >= 12 && dateTimeComponents.hour! < 16 ) {

            timeAndName.text = "Good Afternoon"
        }else{
            timeAndName.text = "Good Evening"
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

    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
           // 1
          let nav = self.navigationController?.navigationBar

          // 2
          nav?.barStyle = UIBarStyle.black
          nav?.tintColor = UIColor.yellow
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    @IBAction func logOutButton(_ sender: UIBarButtonItem) {
        self.loadLoginScreen()
                
    }
    
    func loadLoginScreen(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
        self.present(viewController, animated: true, completion: nil)
    }
    
//    func sendDataToFirstViewController(myData: SendData) {
//        print("token\(myData.token)")
//        userName = myData.name
//        userEmail = myData.email
//        userToken = myData.token
//        userContry = myData.country
//       }

}
