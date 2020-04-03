//
//  DashBoardViewController.swift
//  MyRoot Application
//
//  Created by macbook on 3/18/20.
//  Copyright © 2020 Decagon. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class DashBoardViewController: UIViewController {
    
    
    @IBOutlet weak var timeAndName: UILabel!
    
    @IBOutlet weak var fullName: UILabel!
    
    @IBOutlet weak var plantTrees: UIButton!
    
    
    @IBOutlet weak var totalNumberBigOne: UILabel!
    
    @IBOutlet weak var totalNumberBigtwo: UILabel!
    
    @IBOutlet weak var numberOfTreesOwned: UILabel!
    
    @IBOutlet weak var ownedInAfrica: UILabel!
    
    
    @IBOutlet weak var numberedOwnedInGreatWall: UILabel!
    
    @IBOutlet weak var inTheGreatGreenWall: UILabel!
    
    
    var ApiData = Utility()
    
    @IBOutlet weak var logotBtn: UIBarButtonItem!
    
    var disposedBag = DisposeBag()
    
    var userName = ""
    var userEmail = ""
    var userToken = ""
    var userContry = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        //7FCD40
        //        let color = UIColor(red: 0xFF, green: 0xFF, blue: 0xFF)
        //        let color2 = UIColor(rgb: 0xFFFFFF)
        
        time()
        
        userName = UserDefaults.standard.string(forKey: "name")!
        userEmail = UserDefaults.standard.string(forKey: "email")!
        userContry = UserDefaults.standard.string(forKey: "country")!
        userToken = UserDefaults.standard.string(forKey: "token")!
        fullName.text = userName
        loadData()
        
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
        //let nav = self.navigationController?.navigationBar
        
        // 2
        //nav?.barStyle = UIBarStyle.black
        //  nav?.tintColor = UIColor.yellow
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    @IBAction func logOutButton(_ sender: UIBarButtonItem) {
        // self.loadLoginScreen()
        UserDefaults.standard.set(false, forKey: "loggedIn")
        navigationController?.popToRootViewController(animated: true)
        
    }
    
    
    func loadData(){
        let endpoint = "tree/user/tree"
        let url = "\(ApiData.API)\(endpoint)"
        //  let local = 0
        //  let greenCountry = 0
        var countryArr = [String]()
        
        GetallTrees.shared.reserveTree(urlString: url, token: userToken)
            .subscribe(onNext:{(AllTrees) in
                if AllTrees.status == 200{
                    //update UI
                    if let result = AllTrees.payload{
                        if let numberOfTressIn54Countries = result.countries{
                            self.totalNumberBigOne.text = "\(numberOfTressIn54Countries.count)"
                            
                            
                            self.numberOfTreesOwned.text = "You have \(numberOfTressIn54Countries.count) trees reserved"
                            for result in numberOfTressIn54Countries{
                                let county = result.country
                                countryArr.append(county!)
                                
                            }
                            //  let num = Array(Set(countryArr)).count
                            // print(num)
                            // print(countryArr)
                            if numberOfTressIn54Countries.count < 2{
                                self.ownedInAfrica.text = "in \(numberOfTressIn54Countries.count) country in Africa"
                            }else{
                                self.ownedInAfrica.text = "in \(numberOfTressIn54Countries.count) countries in Africa"
                            }
                            
                            if(numberOfTressIn54Countries.count > 9){
                                self.numberOfTreesOwned.textAlignment = NSTextAlignment.center
                                self.ownedInAfrica.textAlignment = NSTextAlignment.center
                            }
                        }
                    }
                    
                    
                    if let result2 = AllTrees.payload{
                        if let greenWallCount = result2.greenWall?.count{
                            self.totalNumberBigtwo.text = "\(greenWallCount)"
                            self.numberedOwnedInGreatWall.text = "You have \(greenWallCount) trees planted"
                            
                            if(greenWallCount > 9){
                                print("Yeaaaaa")
                                self.numberedOwnedInGreatWall.textAlignment = NSTextAlignment.center
                                self.inTheGreatGreenWall.textAlignment = NSTextAlignment.center
                            }
                            
                            
                        }
                    }
                    
                    
                }
                
                
            },onError: { (Error) in
                
                print("Error: \(String(describing: Error.asAFError))")
                print("Errorcode: \(String(describing: Error.asAFError?.responseCode))")
            }, onCompleted: {
                print("completed")
            }, onDisposed: {
                print("disposed")
            }).disposed(by: disposedBag)
        
    }
    
}

