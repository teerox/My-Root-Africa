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
    var code = "5855"
}





// MARK: - Welcome
struct Welcome: Decodable {
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
    let status: Int?
    let message: String?
    let payload: AllPayload?
}

// MARK: - Payload
struct AllPayload: Codable {
    let date, id, userid, treeType: String?
    let locationType, country: String?
    let longitude, latitude: Int?
    let picture: String?
    let createdAt, updatedAt: String?

}


// MARK: - Welcome
struct AllUserInput2: Codable {
    let status: Int?
    let message: String?
    let payload: Countries?
}

struct Countries:Codable  {
    let pm:AllPayload2
}

// MARK: - Payload
struct AllPayload2: Codable {
    let date, id, userid, treeType: String?
    let locationType, country: String?
    let longitude, latitude: Int?
    let picture: String?
    let createdAt, updatedAt: String?

}






// MARK: - Welcome
struct CompleteData: Codable{
    let email, name: String?
    let treeType, locationType: String?
    let reason: String?
    let occassion, date, country, location: String?
    let longitude, latitude: String?
    
    // MARK: - Reason

  
 
    
    
//
//    var dictionaryRepresentation: [String: Any] {
//        return [
//          "email" : email,
//          "name" : name,
//          "picture" : picture,
//          "treeType" : treeType,
//          "locationType" : locationType,
//          "reason" : [
//            "isOcassion":reason.isOcassion,
//            "isGift":reason.isGift
//          ],
//          "occassion" : occassion,
//          "date" : date,
//          "country" : country,
//                 "location" : location,
//                 "latitude" : latitude
//
//        ]
//
//    }
}


struct SendData {
      var name: String
      var email: String
      var token: String
      var country: String
}


struct Check: Codable {
    let email, name: String
    let picture: String
    let treeType, locationType, reason, occassion: String
    let date, country, location, longitude: String
    let latitude: String
}


struct Tree:Encodable {
    var name:String?
    var email:String?
    var picture: String?
    var treeType: String?
    var locationType: String?
    var reason: Reason?
    var occasion: String?
    var date: String?
    var country: String?
    var location: String?
    var longitude: String?=""
    var latitude: String?=""
    var token:String?
    var new:Bool? = false
}

struct Reason:Encodable {
    var isOccasion:Bool = false
    var isGift: Bool = false
}


struct AllTrees: Codable {
    let status: Int?
    let message: String?
    let payload: Trees?
}

// MARK: - Payload
struct Trees: Codable {
    let countries: [TreeCountry]?
    let greenWall: [TreeCountry]?
}

// MARK: - Country
struct TreeCountry: Codable {
    let locationType, id: String?
    let longitude: Int?
    let picture: String?
    let latitude: Int?
    let reason:Reason2?
    let treeType, country, userid: String?
    let createdAt, updatedAt: String?
    let v: Int?


}

struct Reason2:Codable {
    var isOccasion:Bool?
    var isGift: Bool?
}






struct AllTreesGotten: Codable {
    let status: Int?
    let message: String?
    let payload: EachTree?
}

// MARK: - Payload
struct EachTree: Codable {
    let countries, greenWall: [EachTreeCountry]?
}

// MARK: - Country
struct EachTreeCountry: Codable {
    let locationType, id: String?
    let longitude: Int?
    let picture: String?
    let latitude: Int?
    let reason: MainReason?
    let treeType, country, userid, createdAt: String?
    let updatedAt: String?
    let v: Int?
}

struct MainReason: Codable {
    let isOccasion, isGift: Bool?
}

