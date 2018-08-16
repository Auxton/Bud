//
//  Session.swift
//  Bud
//
//  Created by Austin Odiadi on 15/08/2018.
//  Copyright © 2018 Austin Odiadi. All rights reserved.
//

import Foundation
extension URLSession {
    
    class var sharedSession: URLSession {
        
        struct Session {
            static let session = URLSession(
                configuration:  URLSessionConfiguration.configuration(),
                delegate:       SessionDelegate(),
                delegateQueue:  OperationQueue.main)
        }
        return Session.session
    }
}

class SessionDelegate: NSObject, URLSessionDelegate {
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
        Auth.challenge(challenge) { response in
            completionHandler(response.challenge!, response.credentials)
        }
    }
    
    func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
    }
    
    func urlSession(_ session: URLSession, didBecomeInvalidWithError error: Error?) {
    }
}
