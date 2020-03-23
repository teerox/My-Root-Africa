//
//  ApiRequest.swift
//  MyRoot Application
//
//  Created by macbook on 3/18/20.
//  Copyright © 2020 Decagon. All rights reserved.
//

import Foundation

class SignUpApiRequest{

    private init () {}

    static let shared = SignUpApiRequest()

    func postRequestFunction(urlString:String , user:RegisterData, onCompletion: @escaping (_ success: Bool, _ error: Error?, _ result: [String: Any]?)->()) {

         guard let urlData = URL(string: urlString) else {fatalError()}
               
        var request = URLRequest(url: urlData)
        
         request.httpMethod = "POST"
        var headers = request.allHTTPHeaderFields ?? [:]
        headers["Content-Type"] = "application/json"
        request.allHTTPHeaderFields = headers
       
        print("shared URL : \(request)")
        
          let encoder = JSONEncoder()
              do {
                  let jsonData = try encoder.encode(user)
                  request.httpBody = jsonData
              } catch {
                  print(error)
              }

        var returnRes:[String:Any] = [:]
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                 print("Error0")
                onCompletion(false, error, nil)
            } else {
                guard let data = data else {
                     print("Error001")
                    onCompletion(false, error, nil)
                    return
                }
                    
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode == 400 || httpStatus.statusCode == 200 {
                    do {
                        returnRes = try JSONSerialization.jsonObject(with: data, options: []) as! [String : Any]
                        onCompletion(true, nil, returnRes)
                            print("Response:\(returnRes)")
                    } catch let error as NSError {
                        print("Error1")
                        onCompletion(false, error, nil)
                    }
                } else {
                     print("Error2")
                    onCompletion(false, error, nil)
                }
            }
        }
        task.resume()
    }
}
