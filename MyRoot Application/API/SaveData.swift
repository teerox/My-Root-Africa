//
//  SaveData.swift
//  MyRoot Application
//
//  Created by macbook on 3/25/20.
//  Copyright © 2020 Decagon. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

class SaveData{

    private init () {}

    static let shared = SaveData()
    

func reserveTree(urlString:String,tree: Tree, token:String) -> Observable<AllUserInput> {
    let headers:HTTPHeaders = [
               "Authorization" : "Bearer \(token)"
           ]
    print("headers \(headers)")
    return Observable.create{observer -> Disposable in
        let task = AF.request(urlString, method: .post, parameters: tree, encoder: JSONParameterEncoder.default, headers: headers)
        
        task.validate(statusCode: 200..<600)
        .responseDecodable(of: AllUserInput.self){ res in
            switch res.result {
                case let .failure(error): observer.onError(error)
                    
                case let .success(allUserInput):
                    observer.onNext(allUserInput)
            }
            
        }
        
        return Disposables.create {
            
        }
    }
}
}

