//
//  HomeVC.swift
//  Bud
//
//  Created by Austin Odiadi on 15/08/2018.
//  Copyright © 2018 Austin Odiadi. All rights reserved.
//

import UIKit

class HomeVC: BaseVC {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBOutlet weak var homeView: HomeView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataManager.fetchTransactions { [weak self] (error, transactions: TData?) in
            switch error {
                case .Successful?:
                    guard let data = transactions?.data else { return }
                    self?.homeView.list = data
                    break
                default:
                    self?.alert("", (error?.errorMessage())!)
                    break
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
