//
//  GetallTrees.swift
//  MyRoot Application
//
//  Created by macbook on 3/26/20.
//  Copyright © 2020 Decagon. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

class GetallTrees{

    private init () {}

    static let shared = GetallTrees()

    
    func reserveTree(urlString:String, token:String)->Observable<AllTreesGotten>{
        let headers:HTTPHeaders = [
                   "Authorization" : "Bearer \(token)"
               ]
         return Observable.create{observer -> Disposable in
        let task = AF.request(urlString, headers: headers)
            task.validate(statusCode: 200..<600)
                    .responseDecodable(of: AllTreesGotten.self){ res in
                            
                        switch res.result {
                            case let .failure(error): observer.onError(error)

                            case let .success(allTreesGotten):
                                observer.onNext(allTreesGotten)
                        }

                    }
                    return Disposables.create {

                    }
                }
            }
    
}
