//
//  RequestParams.swift
//  Bud
//
//  Created by Austin Odiadi on 15/08/2018.
//  Copyright © 2018 Austin Odiadi. All rights reserved.
//

import UIKit

enum HTTPMethod: Int {
    case GET
    case PUT
    case POST
    case DELETE
};

class RequestParams {
    
    var body: JSONData?
    var baseURL: String?
    var endpoint: String?
    var headers: JSONData?
    var HTTPMethod: HTTPMethod?
    var miscellaneous: JSONData?
    
     init(baseURL: String, body: JSONData? = nil, headers: JSONData? = nil) {
        
        self.body       = body
        self.baseURL    = baseURL
        self.headers    = (headers != nil) ? headers : RequestParams.basic()
    }
    
    class func basic() -> JSONData {
        var header = JSONData()
        
        header["Accept"]        = "application/json"
        header["Content-Type"]  = "application/json"
        
        return header
    }
    
    func method() -> String?  {
        
        switch (self.HTTPMethod) {
            case .GET?: return "GET"
            case .PUT?: return "PUT"
            case .POST?: return "POST"
            case .DELETE?: return "DELETE"
            case .none: break
        }
        
        return nil
    }
}
