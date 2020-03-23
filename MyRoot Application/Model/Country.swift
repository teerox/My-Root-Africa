//
//  AllCountry.swift
//  MyRoot Application
//
//  Created by macbook on 3/18/20.
//  Copyright © 2020 Decagon. All rights reserved.
//

import Foundation

class Country {
    
    let allCountriesAndCode = AllCountriesAndCode()
    let allAfricanCountry = AllAfricaCountriesAndCode()
    
     func countryAndCodes() -> [String:String]{
        guard let cacListData = allCountriesAndCode.countryAndCodeString() .data(using: .utf8) else { return ["error": "Value for country not found"]
        }
        struct countryData:Codable{
                let name:String
                let dialCode:String
                let code:String
                
                private enum CodingKeys:String, CodingKey{
                    case name
                    case dialCode = "dial_code"
                    case code
                }
            }
            let countryAndCodeDecoder = JSONDecoder()
            var returnList = [String:String]()
            do{
                let countries = try countryAndCodeDecoder.decode([countryData].self, from: cacListData)
                for country in countries {
    //                print(country.name)
                    returnList[country.name] = country.dialCode
    //                print(returnList)
                    
                }
            }catch{
                "Failed to decode country and code \(error.localizedDescription)"
            }
            return returnList
        }
    
    
    func getCountries() -> [String] {
        let listOfCountryAndCode = countryAndCodes()
        var allCountryList = [String]()
        for key in listOfCountryAndCode.keys{
            allCountryList.append(key)
        }
        return allCountryList
    }
    
    
    
    
     func africanCountryAndCodes() -> [String:String]{
        
        guard let cacListData = allAfricanCountry.countryAndCodeString()
            .data(using: .utf8) else { return ["error": "Value for country not found"]
        }
        struct countryData:Codable{
                let name:String
                let dialCode:String
                let code:String
                
                private enum CodingKeys:String, CodingKey{
                    case name
                    case dialCode = "dial_code"
                    case code
                }
            }
            let countryAndCodeDecoder = JSONDecoder()
            var returnList = [String:String]()
            do{
                let countries = try countryAndCodeDecoder.decode([countryData].self, from: cacListData)
                for country in countries {
    //                print(country.name)
                    returnList[country.name] = country.dialCode
    //                print(returnList)
                    
                }
            }catch{
                "Failed to decode country and code \(error.localizedDescription)"
            }
            return returnList
        }
    
    
    func getAfricanCountries() -> [String] {
         let listOfCountryAndCode = africanCountryAndCodes()
         var allCountryList = [String]()
         for key in listOfCountryAndCode.keys{
             allCountryList.append(key)
         }
         return allCountryList
     }
}
