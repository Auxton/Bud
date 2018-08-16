//
//  BaseVC.swift
//  TFLPortal
//
//  Created by Austin Odiadi on 04/08/2018.
//  Copyright © 2018 Austin Odiadi. All rights reserved.
//

import UIKit

class BaseVC: UIViewController {
    
    lazy var dataManager: DataManager = {
        return DataManager()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func alert(_ title: String, _ message: String? = nil, completion: @escaping (UIAlertActionStyle) -> () = {_ in}) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
            case .default: break
            case .cancel: break
            case .destructive: break
            }
            
            completion(action.style)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
