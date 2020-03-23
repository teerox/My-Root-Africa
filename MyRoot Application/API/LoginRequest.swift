//
//  LoginRequest.swift
//  MyRoot Application
//
//  Created by macbook on 3/20/20.
//  Copyright © 2020 Decagon. All rights reserved.
//

import Foundation

struct LoginRequest {
    
    func save(urlString:String,user:Login){
        guard let urlData = URL(string: urlString) else {return}
        var request = URLRequest(url: urlData)
           request.httpMethod = "POST"
        var headers = request.allHTTPHeaderFields ?? [:]
              headers["Content-Type"] = "application/json"
              request.allHTTPHeaderFields = headers
           let encoder = JSONEncoder()
           do {
               let jsonData = try encoder.encode(user)
               request.httpBody = jsonData
           } catch {
               print(error)
           }
        
           let config = URLSessionConfiguration.default
           let session = URLSession(configuration: config)
           let task = session.dataTask(with: request) { (responseData, response, responseError) in
               if responseError != nil{
                  print(responseError!)
                   return
           }
                 if let safeData = responseData {
                          if let result = self.parseJSON(safeData){
                            print("API AUT:\(result.payload.name)")
                            let hashMap:[String:LoginSucessful] = ["result":result]
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notification"), object: nil, userInfo: hashMap)
                              }
                      }
           }
           task.resume()
       }

    
       func parseJSON(_ responseData:Data)-> LoginSucessful?  {
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode(LoginSucessful.self, from: responseData)
                let status = decodedData.status
               let message = decodedData.message
               let token = decodedData.token
                let result = decodedData.payload
               let newResponse = LoginSucessful(status: status, message: message, payload: result, token: token)
                return newResponse
            } catch  {
               print(error)
                return nil
            }
        }
}
