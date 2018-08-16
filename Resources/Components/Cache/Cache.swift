//
//  BudCache.swift
//  Bud
//
//  Created by Austin Odiadi on 16/08/2018.
//  Copyright © 2018 Austin Odiadi. All rights reserved.
//

import UIKit
import Foundation

class Cache <K: AnyObject, V: AnyObject> {
    let cache = NSCache<K, V>()
    
    public func get(with key: K) -> V? {
        guard let instanceFromCache = cache.object(forKey: key as K) else {
            return nil
        }
        
        return instanceFromCache as V
    }
    
    public func save(_ object: V, with key: K) {
        cache.setObject(object as V, forKey: key as K)
    }
}

class MCache : Cache<NSString, UIImage> {
    
    static let sharedInstance = MCache()
    
    private override init() {
    }
}

