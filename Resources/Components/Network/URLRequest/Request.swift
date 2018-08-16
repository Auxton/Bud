//
//  Request.swift
//  Bud
//
//  Created by Austin Odiadi on 15/08/2018.
//  Copyright © 2018 Austin Odiadi. All rights reserved.
//

import Foundation

extension NSURLRequest {
    
    class func requestWithParameters(params:RequestParams) ->NSURLRequest{
        
        let url = URL(string:(params.endpoint!), relativeTo: URL(string:(params.baseURL)!))
        let request = NSMutableURLRequest(url:url!)
        
        request.httpMethod = params.method()!
   
        if let body = params.body {
            request.httpBody = try! JSONSerialization.data(withJSONObject:body, options:JSONSerialization.WritingOptions.prettyPrinted)
        }
        
        if let headers = params.headers {
            for (key, value) in headers{
                request.addValue(value as! String, forHTTPHeaderField:key)
            }
        }
        
        request.httpShouldHandleCookies = true
        return request;
    }
}

extension String{
    func get<T>(parameters:RequestParams, completion: @escaping (Response<T>) -> () = { _ in }) {
            
        parameters.endpoint     = self
        parameters.HTTPMethod   = .GET
        let request: URLRequest = NSURLRequest.requestWithParameters(params:parameters) as URLRequest
            
        let task = URLSession.sharedSession.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            completion(Response(data:data, error:error, response:response))
        })
        task.resume()
    }
}

struct Response<T: Decodable> {
    
    let data: Data?
    var error: Error?
    let response: URLResponse?
    
    var asJSON: JSON? {
        guard let data = data else { return nil; }
        do {
            return try JSONDecoder().decode(T.self, from: data)
        }
        catch { print("\(error)") }
        
        return nil;
    }
    
    var code: Int? {
        if let response = response {
            return (response as! HTTPURLResponse).statusCode
        }
        
        return nil
    }
    
    var errorMsg: String? {
        if let error = error {
            return error.localizedDescription
        }
        
        return nil
    }
    
    var ok: Bool? {
        if let code = self.code {
            
            switch (code){
            case 200...299:
                return true
            case 300...500:
                return false
            default:
                return false
            }
        }
        
        return false
    }
}
