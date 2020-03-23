//
//  UserManager.swift
//  MyRoot Application
//
//  Created by macbook on 3/18/20.
//  Copyright © 2020 Decagon. All rights reserved.
//

import Foundation

//protocol UserManagerDelegate {
//    func didFetch(_ userManager:UserManager, response: ResponseGiven)
//    func didFailWithError(error:Error)
//}


struct UserManager{
    
    var ApiData = Utility()
    var login = LoginRequest()
  
    func login(userData:Login) {
        let endpoint = "user/login"
        let url = "\(ApiData.API)\(endpoint)"
        login.save(urlString: url, user: userData)
    }
    
    
   
}



