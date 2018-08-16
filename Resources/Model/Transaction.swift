//
//  Transaction.swift
//  TFLPortal
//
//  Created by Austin Odiadi on 04/08/2018.
//  Copyright © 2018 Austin Odiadi. All rights reserved.
//

import UIKit

struct Transaction: Codable {
    
    let id: String
    let date: String
    let description: String
    let categoryId: Int
    let currency: String
    let amount: Amount
    let product: Product
}

// Private
extension Transaction {
    private enum CodingKeys : String, CodingKey {
        case id
        case date
        case description
        case categoryId = "category_id"
        case currency
        case amount
        case product
    }
}

struct Amount: Codable {
    let value: Double
    let currencyIso: String
}

// Private
extension Amount {
    private enum CodingKeys : String, CodingKey {
        case value
        case currencyIso = "currency_iso"
    }
}

struct Product : Codable {
    let id: Int
    let title: String
    let icon: String
}
