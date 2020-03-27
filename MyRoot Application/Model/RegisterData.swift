//
//  RegisterData.swift
//  MyRoot Application
//
//  Created by macbook on 3/18/20.
//  Copyright © 2020 Decagon. All rights reserved.
//

import Foundation


struct RegisterData:Codable {
    var name: String
    var email: String
    var password: String
    var country: String
    var phone: String
    //var isVerified:Bool
}


struct MainResponse:Codable {
      var status:Int
      var message:String
    var response:ResponseGiven
}

struct ResponseGiven:Codable {
    var status:Int
    var message:String
    var token:String?
}

struct Message:Codable {
    var message:String
    var status:Int
    
}

struct Auth:Codable {
    var code:String
}





// MARK: - Welcome
struct Welcome: Codable {
    let status: Int?
    let message: String?
    let payload: Payload?
    let token: String?
}

// MARK: - Payload
struct Payload: Codable {
    let isVerified: Bool?
    let id, name, email, password: String?
    let country, phone, createdAt, updatedAt: String?
    let v: Int?

    enum CodingKeys: String, CodingKey {
        case isVerified
        case id = "_id"
        case name, email, password, country, phone, createdAt, updatedAt
        case v = "__v"
    }
}



// MARK: - Welcome
struct Login: Codable {
    let email: String
    let password: String
}


// MARK: - Welcome
struct LoginSucessful: Codable {
    let status: Int?
    let message: String?
    let payload: LoginResult?
    let token: String?
}

// MARK: - Payload
struct LoginResult: Codable {
    let isVerified: Bool?
    let id, name, email, password: String?
    let country, phone, createdAt, updatedAt: String?
    let v: Int?
    

    enum CodingKeys: String, CodingKey {
        case isVerified
        case id = "_id"
        case name, email, password, country, phone, createdAt, updatedAt
        case v = "__v"
    }
}



struct ForgotPasswordEmail:Codable {
    var email:String?
}



struct ResetPasswordValues:Codable {
    let email:String?
    let code:String?
    let password:String?
}





struct fullData {
    let birthDayRecieved: String
    let aniversaryRecieved: String
    let holidaysRecieved: String
    let othersRecieved: String
    let climateAction: String
    let toCreateAjob: String
    let gift: String
    let country: String
    let remote: String
    let inPerson: String
    let sendDecorativeTree: String
    let sendFruitTree: String
    let sendEnvironmentalTree: String
}

//struct CompleteData: Codable {
//    let email:String
//    let name:String
//    let picture:String
//    let locationType:String
//    let reason:Reason
//    let occasion:String
//    let date:String
//    let country:String
//    let location:String
//    let longitude:String
//    let latitude:String
//
//}
//
//struct Reason: Codable {
//   let isOccasion:Bool
//   let isGift:Bool
//
//}



// MARK: - Welcome
struct AllUserInput: Codable {
    let status: Int
    let message: String
    let payload: AllPayload
}

// MARK: - Payload
struct AllPayload: Codable {
    let date, id, userid, type: String
    let payloadDescription, country: String
    let longitude, latitude: Int
    let picture: String
    let createdAt, updatedAt: String

}



// MARK: - Welcome
struct CompleteData: Codable {
    let email, name: String
    let picture: String
    let treeType, locationType: String
    let reason: Reason
    let occassion, date, country, location: String
    let longitude, latitude: String
}

// MARK: - Reason
struct Reason: Codable {
    let isOcassion, isGift: Bool
}
