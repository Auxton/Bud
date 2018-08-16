//
//  CoreDataStack.swift
//  Bud
//
//  Created by Austin Odiadi on 15/08/2018.
//  Copyright © 2018 Austin Odiadi. All rights reserved.
//

import CoreData
typealias StackContext = NSManagedObjectContext

class CoreDataStack {
    
    fileprivate let model: String
    
    lazy var mainContext: NSManagedObjectContext = {
        return self.container.viewContext
    }()
    
    fileprivate var writeContext: NSManagedObjectContext
    
    lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.model)
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        return container
    }()
    
    init(cdmodel: String? = nil) {
        self.model = cdmodel!
        
        writeContext = NSManagedObjectContext.init(concurrencyType: .privateQueueConcurrencyType)
        writeContext.persistentStoreCoordinator = self.container.persistentStoreCoordinator
        
        setMergePolicies()
        NotificationCenter.default.addObserver(self, selector: #selector(mergeChanges(changes:)), name: NSNotification.Name.NSManagedObjectContextObjectsDidChange, object: nil)
    }
    
    func setMergePolicies () {
        mainContext.mergePolicy  = NSMergePolicy(merge: .mergeByPropertyObjectTrumpMergePolicyType)
        writeContext.mergePolicy = NSMergePolicy(merge: .mergeByPropertyObjectTrumpMergePolicyType)
    }
    
    @objc private func mergeChanges(changes: Notification)  {
        
        let context: NSManagedObjectContext = changes.object as! NSManagedObjectContext
        
        guard changes.userInfo != nil, context != self.writeContext else {
            return
        }
        
        self.mainContext.perform {
            self.mainContext.mergeChanges(fromContextDidSave: changes)
        }
    }
}

// MARK: Internal
internal extension CoreDataStack {
    
    func commitMM (completion: (Bool?, NSError?) -> () = { _,_  in }) {
        
        guard mainContext.hasChanges else {
            completion(true, nil);  return
        }
        
        var error: NSError?
        
        do {
            try mainContext.save()
        }
        catch let nserror as NSError {
            error = nserror
        }
        
        completion(error == nil, error)
    }
    
    func commit (completion: (Bool?, NSError?) -> () = {_,_ in}) {
        
        guard writeContext.hasChanges else {
            completion(true, nil); return
        }
        
        do {
            try writeContext.save()
            
            commitMM { (success, error) in
                completion(error == nil, error)
            }
        }
        catch let nserror as NSError {
            completion(false, nserror)
        }
    }
}

// MARK: Private
private extension CoreDataStack {
    
    func privateContext() -> NSManagedObjectContext {
        return NSManagedObjectContext.init(concurrencyType: .privateQueueConcurrencyType)
    }
}

// MARK: Public
extension CoreDataStack {
    
    func context() -> StackContext {
        var newContext: NSManagedObjectContext = self.privateContext()
        
        func context () -> StackContext {
            
            newContext.parent = self.writeContext
            newContext.mergePolicy = NSMergePolicy(merge: .mergeByPropertyObjectTrumpMergePolicyType)
            
            newContext.perform {
                newContext.undoManager = nil
            }
            
            return newContext
        }
        
        return context()
    }
}

