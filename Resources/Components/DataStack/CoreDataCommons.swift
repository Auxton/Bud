//
//  CoreDataFetch.swift
//  Bud
//
//  Created by Austin Odiadi on 15/08/2018.
//  Copyright © 2018 Austin Odiadi. All rights reserved.
//

import UIKit
import CoreData

class CoreDataCommons {
    static let sharedInstance = CoreDataCommons()
    var dataStack: CoreDataStack
    
    private init() {
        dataStack = CoreDataStack(cdmodel: "Bud")
    }
}


// MARK: Public
extension CoreDataCommons {
    
    // Get: Sync
    func get<T: NSManagedObject>(predicate: NSPredicate? = nil) -> [T]? {
        let request: NSFetchRequest< T > = T.fetchRequest() as! NSFetchRequest< T >
        request.predicate = predicate
        
        let array: [ T ] = try! dataStack.mainContext.fetch(request)
        
        return array
    }
    
    // Get: Async
    func get<T: NSManagedObject>(predicate: NSPredicate? = nil, _ completion: @escaping (Error?, [T]?) -> ()) {
        
        self.get(context: dataStack.context(), predicate: predicate) { (error, object: [ T ]?) in
            completion(error, object)
        }
    }
    
    func get<T: NSManagedObject>(context: StackContext, predicate: NSPredicate? = nil, descriptor: NSSortDescriptor? = nil, completion: @escaping (Error? , [T]?) -> ()) {
        let request: NSFetchRequest< T > = T.fetchRequest() as! NSFetchRequest< T >
        
        request.predicate = predicate
        
        context.perform {
            let array: [ T ] = try! request.execute()
            
            completion(nil, array)
        }
    }
    
    // Insert
    func insert<T: NSManagedObject>(_ instance: [JSONData], completion: @escaping (NSError?, T?) -> () = {_,_  in }) {
        
        var keys: [String] = [String]()
        
        T.entity().attributesByName.enumerated().forEach {
            keys.append($0.element.key)
        }
        
        let context: StackContext = dataStack.context()
        
        context.perform {
            
            instance.forEach({ (person) in
                let name: String = NSStringFromClass( T.self )
                let instance = NSEntityDescription.insertNewObject(forEntityName: name, into: context)
                
                keys.forEach({ (key) in
                    instance.setValue(person[key], forKey: key)
                })
            })
            
            try! context.save()
            
            self.dataStack.commit(completion: { (success, error) in
                completion( error, nil )
            })
        }
    }
    
    // Update
    func update<T: NSManagedObject>(_ instance: Any, completion: @escaping (Error?, T?) -> () = {_,_  in }) {
        
    }
    
    // Delete
    func delete<T: NSManagedObject>(completion: @escaping (Error?, T?) -> () = {_,_  in }) {
        
        let name: String = NSStringFromClass( T.self )
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: name)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        var err: Error?
        let context: StackContext = dataStack.context()
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            err =  error
        }
        
        completion(err, nil)
    }
    
}


