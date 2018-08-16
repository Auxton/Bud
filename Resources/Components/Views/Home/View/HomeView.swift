//
//  HomeView.swift
//  Bud
//
//  Created by Austin Odiadi on 15/08/2018.
//  Copyright © 2018 Austin Odiadi. All rights reserved.
//

import UIKit

enum BState: Int {
    
    case Edit = 0x01
    case Done = 0x02
    
    func text() -> String {
        switch self {
        case .Edit:
            return "Edit"
        case .Done:
            return "Done"
        }
    }
}

class HomeView: UIViewNib {
    let reuseIdentifier = "HomeViewCellIdentifier"
    
    var list: [Transaction] = [Transaction](){
        didSet {
            reload()
        }
    }
    
    private var buttonState: BState = .Edit
    private let refreshControl = UIRefreshControl()
    
    @IBOutlet weak var tableView: UITableView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initializeNib()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initializeNib()
    }
    
    override func initializeNib() {
        super.initializeNib()
        
        setUp()
    }
    
    func setUp() {
        
        tableView.tableFooterView = UIView()
        tableView.register(UINib.init(nibName: "HomeViewCell", bundle: nil), forCellReuseIdentifier: reuseIdentifier)
    }
    
    func reload() {
        tableView.reloadData()
    }
    
    // MARK: - IBAction
    
    @IBAction func editButtonPushed(_ sender: UIButton) {
        
        if buttonState == .Edit {
            buttonState = .Done
        }
        else {
           buttonState = .Edit
        }
        
        sender.setTitle(buttonState.text(), for: .normal)
        tableView.setEditing(!tableView.isEditing, animated: true)
    }
    
    // MARK: - Helper -
}

extension HomeView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! HomeViewCell
        
        cell.configure(list[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        tableView.beginUpdates()
        
        list.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
        
        tableView.endUpdates()
    }
}
