//
//  AuthApiRequest.swift
//  MyRoot Application
//
//  Created by macbook on 3/19/20.
//  Copyright © 2020 Decagon. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift


class AuthApiRequest{

    private init () {}

    static let shared = AuthApiRequest()
    
    
    func getApi(urlString:String,code:Dictionary<String, String>, token:String,  onCompletion: @escaping (_ success: Bool, _ error: Error?, _ result: Welcome?)->())  {

            let headers: HTTPHeaders = [
                       .authorization("Bearer \(token)"),
                       .accept("application/json")
                   ]
            let parameters = code
            AF.request(urlString, method: .put, parameters: parameters, headers: headers)
                .validate(statusCode: 0..<500)
             .responseDecodable(of: Welcome.self){ res in
                debugPrint(res.result)
                 switch res.result {
                   
                     case let .failure(error): onCompletion(false, error, nil)
                       
                         
                     case let .success(Welcome): onCompletion(true, nil, Welcome)
                      
                    
                 }
                 
             }
             
          
        }
    }
    
