//
//  Formatter.swift
//  Bud
//
//  Created by Austin Odiadi on 26/07/2018.
//  Copyright © 2018 Austin Odiadi. All rights reserved.
//

import Foundation

class Formatter {
    static let sharedInstance = Formatter()
    
    let formatter: NumberFormatter
    
    private init() {
        self.formatter = NumberFormatter()
        self.formatter.numberStyle = .currency
        self.formatter.locale = NSLocale.current
    }
    
    func currency(format number: Double) -> String {
        return self.formatter.string(from: NSNumber(value: number))!
    }
    
    func currencySymbol(withCode code: String) -> String? {
        let locale = NSLocale(localeIdentifier: code)
        return locale.displayName(forKey: NSLocale.Key.currencySymbol, value: code)
    }
}
