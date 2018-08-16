//
//  ViewConfigs.swift
//  Bud
//
//  Created by Austin Odiadi on 15/08/2018.
//  Copyright © 2018 Austin Odiadi. All rights reserved.
//

import Foundation

// View
let kSplashDuration = 3.0


// Session
let kSessiontimeOut: UInt = 60

// Alias
typealias JSON = Any
typealias JSONData = [String: JSON]
typealias TransactionCompletion = (DataManagerError? , [Transaction]?) -> ()

//API
enum API {
    static let Transaction      = "5b33bdb43200008f0ad1e256"
    static let BaseURL: String  = "https://www.mocky.io/v2/"
}

// DataManager Error
enum DataManagerError: Error {
    
    case Unknown
    case Successful
    case FailedRequest
    case InvalidResponse
    
    func errorMessage() -> String {
        switch self {
        case .Unknown:
            return "Unknown error."
        case .Successful:
            return ""
        case .FailedRequest:
            return "Request failed."
        case .InvalidResponse:
            return "Invalid response."
        }
    }
    
    static var count: Int { return DataManagerError.InvalidResponse.hashValue + 1 }
}
