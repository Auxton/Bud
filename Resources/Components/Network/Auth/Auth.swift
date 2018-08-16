//
//  Auth.swift
//  Bud
//
//  Created by Austin Odiadi on 15/08/2018.
//  Copyright © 2018 Austin Odiadi. All rights reserved.
//

import UIKit

class Auth {

    class func challenge(_ challenge: URLAuthenticationChallenge, completion: @escaping (AuthResponse) -> Void){
        completion(AuthResponse(challengeType: challenge))
    }
}

struct AuthResponse {
    var challengeType: URLAuthenticationChallenge?
    
    var challenge: URLSession.AuthChallengeDisposition? {
        // Add unique / custom qualifying condition(s)
        return .performDefaultHandling
    }
    
    var credentials: URLCredential{
        // Add unique / custom qualifying condition(s)
        return URLCredential(trust:(challengeType?.protectionSpace.serverTrust)!)
    }
}
