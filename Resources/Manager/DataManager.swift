//
//  DataManager.swift
//  Bud
//
//  Created by Austin Odiadi on 14/08/2018.
//  Copyright © 2018 Austin Odiadi. All rights reserved.
//

import UIKit
import CoreData

final class DataManager {
    
    private lazy var dataStack: CoreDataCommons = {
        return CoreDataCommons.sharedInstance
    }()
    
    // MARK:- Init -
    
    init() {
    }
    
    // MARK:- API -
    
    func fetchTransactions<T: Decodable>(completion: @escaping (DataManagerError? , T?) -> ()) {
        
        API.Transaction.get(parameters: RequestParams(baseURL: API.BaseURL)) { [weak self] (response: Response<T>) in
            self?.fetchDidFinish(response, completion: completion)
        }
    }
    
    func fetchImage(link: String, completion: @escaping (DataManagerError? , Thumbnail?) -> ()) {
        
        link.get(parameters: RequestParams(baseURL: "")) { (response: Response<Data>) in
            if let thumbnail = Thumbnail(data: response.data as JSON) as Thumbnail? {
                completion(.Successful, thumbnail)
            }
            else {
                completion(.FailedRequest, nil)
            }
        }
    }
    
    // MARK:- Helper -
    
    private func fetchDidFinish<T>(_ response: Response<T>, completion: @escaping (DataManagerError? , T?) -> ()) {

        if let _ = response.error {
            completion( .FailedRequest, nil)
        }
        else if let json = response.asJSON as! T? {

            if response.ok! {
                completion( .Successful, json )
            }
            else {
                completion( .InvalidResponse, nil )
            }
        }
        else{
            completion(.FailedRequest, nil)
        }
    }
    
    
    // MARK:- DB Data -
    
    func get<T: NSManagedObject>(completion: @escaping (Error? , [T]?) -> ()) {

        self.dataStack.get { (error, data: [T]?) in
            completion(error, data)
        }
    }
    
    func save<T: NSManagedObject>(_ object: [JSONData], as: T.Type) {
        DispatchQueue.global(qos: .background).async {
            
            guard let object = object as [JSONData]? else { return }
            
            self.dataStack.insert(object, completion: { (error, info: T?) in
            })
        }
    }
}
