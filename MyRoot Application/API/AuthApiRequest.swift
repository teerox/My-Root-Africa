//
//  AuthApiRequest.swift
//  MyRoot Application
//
//  Created by macbook on 3/19/20.
//  Copyright © 2020 Decagon. All rights reserved.
//

import Foundation


class AuthApiRequest{

    private init () {}

    static let shared = AuthApiRequest()

    func save(urlString:String,token:String,user:Auth, onCompletion: @escaping (_ success: Bool, _ error: Error?, _ result: Welcome?)->()){

        guard let urlData = URL(string: urlString) else {fatalError()}

        var request = URLRequest(url: urlData)
        request.httpMethod = "PUT"

        var headers = request.allHTTPHeaderFields ?? [:]
        headers["Authorization"] = "Bearer \(token)"
        print("My token \(token)")
        request.allHTTPHeaderFields = headers

        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(user)
            request.httpBody = jsonData
        } catch {
            print("Line37Error:\(error)")
        }

        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
        if let error = responseError {
                 print("Error0")
                onCompletion(false, error, nil)
            }

            if let safeData = responseData
            {
             if let result = self.parseJSON(safeData)
             {
             onCompletion(true, nil, result)
             }
            }

        }
        task.resume()

    }

    
    func parseJSON(_ responseData:Data)-> Welcome? {
         let decoder = JSONDecoder()

         do {
            let decodedData = try decoder.decode(Welcome.self, from: responseData)
            let all = decodedData
            let message = all.message
            let status = all.status
            let  payload = all.payload
            let token = all.token
            let newResponse = Welcome(status: status, message: message, payload: payload, token: token)
             return newResponse
         } catch  {
            print("Line74Error:\(error)")
             return nil
         }
     }


}

