//
//  SessionConfig.swift
//  Bud
//
//  Created by Austin Odiadi on 15/08/2018.
//  Copyright © 2018 Austin Odiadi. All rights reserved.
//

import Foundation

extension URLSessionConfiguration{
    
    class func configuration() -> URLSessionConfiguration{
        return Configuration(headers:[:])
    }
    
    class func Configuration(headers: Any?) -> URLSessionConfiguration{
        let config = URLSessionConfiguration.default
        
        config.timeoutIntervalForRequest    = TimeInterval(kSessiontimeOut)
        config.timeoutIntervalForResource   = TimeInterval(kSessiontimeOut)
        config.httpAdditionalHeaders        = (headers as! [AnyHashable : Any])
        config.httpShouldUsePipelining      = true
        config.allowsCellularAccess         = true
        return config
    }
}
