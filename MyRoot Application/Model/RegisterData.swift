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

struct ErrorMessage:Codable {
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
    let status: Int
    let message: String
    let payload: LoginResult
    let token: String
}

// MARK: - Payload
struct LoginResult: Codable {
    let isVerified: Bool
    let id, name, email, password: String
    let country, phone, createdAt, updatedAt: String
    let v: Int
    

    enum CodingKeys: String, CodingKey {
        case isVerified
        case id = "_id"
        case name, email, password, country, phone, createdAt, updatedAt
        case v = "__v"
    }
}


struct ForgotPassword {
    let email:String
}

struct RequestEmailResponse {
    let status:Int
    let email:String
}



struct ResetPassword {
    let email:String
    let code:String
    let password:String
}

struct ResetPasswordResponse {
    let status:Int
    let message:String
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
