//
//  Validator.swift
//  MyRoot Application
//
//  Created by macbook on 3/18/20.
//  Copyright © 2020 Decagon. All rights reserved.
//

import Foundation

class ValidationError: Error {
    var message: String
    
    init(_ message: String) {
        self.message = message
    }
}

protocol ValidatorConvertible {
    func validated(_ value: String) throws -> String
}

enum ValidatorType {
    case email
    case password
    case fullname
    case country
    case requiredField(field: String)
    case phone
    case codeValidator
}

enum VaildatorFactory {
    static func validatorFor(type: ValidatorType) -> ValidatorConvertible {
        switch type {
        case .email: return EmailValidator()
        case .password: return PasswordValidator()
        case .fullname: return NameValidator()
        case .country: return CountryValidator()
        case .requiredField(let fieldName): return RequiredFieldValidator(fieldName)
        case .phone: return PhoneNumberValidator()
        case .codeValidator: return CodeValidator()
        }
    }
}

//"J3-123A" i.e
struct CountryValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
           guard value != "" else {throw ValidationError("Country is Required")}
          return value
      }
}

struct CodeValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
           guard value != "" else {throw ValidationError("Code is Required")}
          guard value.count == 4 else {throw ValidationError("Invalid Code!")}
          return value
      }
}


class PhoneNumberValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
         guard value != "" else {throw ValidationError("PhoneNumber is Required")}
        guard value.count > 5 else {throw ValidationError("Invalid phone number!")}
        return value
    }
}

struct RequiredFieldValidator: ValidatorConvertible {
    private let fieldName: String
    
    init(_ field: String) {
        fieldName = field
    }
    
    func validated(_ value: String) throws -> String {
        guard !value.isEmpty else {
            throw ValidationError("Required field " + fieldName)
        }
        return value
    }
}

struct NameValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        guard value.count >= 5 else {
            throw ValidationError("Name must contain more than three characters" )
        }
        guard value != "" else {
                  throw ValidationError("Full Name Required" )
              }
        return value
    }
}

struct PasswordValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        guard value != "" else {throw ValidationError("Password is Required")}
        guard value.count >= 6 else { throw ValidationError("Password must have at least 6 characters") }
        
        do {
            if try NSRegularExpression(pattern: "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{6,}$",  options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                throw ValidationError("Password must be more than 6 characters, with at least one character and one numeric character")
            }
        } catch {
            throw ValidationError("Password must be more than 6 characters, with at least one character and one numeric character")
        }
        return value
    }
}

struct EmailValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        do {
            if try NSRegularExpression(pattern: "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$", options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                throw ValidationError("Invalid e-mail Address")
            }
        } catch {
            throw ValidationError("Invalid e-mail Address")
        }
        return value
    }
}
