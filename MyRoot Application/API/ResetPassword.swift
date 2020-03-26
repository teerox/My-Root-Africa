//
//  ResetPassword.swift
//  MyRoot Application
//
//  Created by macbook on 3/25/20.
//  Copyright © 2020 Decagon. All rights reserved.
//

import Foundation

class ResetPassword{

    private init () {}

    static let shared = ResetPassword()

    func save(urlString:String,userDetails:ResetPasswordValues, onCompletion: @escaping (_ success: Bool, _ error: Error?, _ result: Message?)->()){
        
        
        guard let urlData = URL(string: urlString) else {fatalError()}

        var request = URLRequest(url: urlData)
        request.httpMethod = "POST"

        var headers = request.allHTTPHeaderFields ?? [:]
        headers["Content-Type"] = "application/json"
       
        request.allHTTPHeaderFields = headers

        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(userDetails)
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
    
    
    func parseJSON(_ responseData:Data)-> Message? {
            let decoder = JSONDecoder()

            do {
               let decodedData = try decoder.decode(Message.self, from: responseData)
               let all = decodedData
               let message = all.message
               let status = all.status
    
                let newResponse = Message(message: message, status: status)
                return newResponse
            } catch  {
               print("Line74Error:\(error)")
                return nil
            }
        }
}
