//
//  HomeViewCell.swift
//  Bud
//
//  Created by Austin Odiadi on 15/08/2018.
//  Copyright © 2018 Austin Odiadi. All rights reserved.
//

import UIKit

class HomeViewCell: UITableViewCell {

    var formatter: Formatter?
    var cache: MCache?
    
    @IBOutlet weak var value: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var icon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cache = MCache.sharedInstance
        formatter = Formatter.sharedInstance
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(_ transaction: Transaction) {
        
        title.text      = transaction.description
        subtitle.text   = transaction.description
        
        loadImage(with: transaction.product.icon)
        
        if let figure = transaction.amount.value as Double? ,
            let cost = formatter?.currency(format: figure) {
            value.text = "\(cost)"
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        icon.layoutIfNeeded()
        icon.circleWithBorder(borderColor: UIColor.init(rgb: 0xd4d4d4), strokeWidth: 1)
    }
    
}

private extension HomeViewCell {
    
    func loadImage(with key :String) {
        icon.image = nil
        
        if let image = cache?.get(with: key as NSString) {
            icon.image = image
            return;
        }

        DataManager().fetchImage(link: key, completion: { [weak self] (error, thumbnail: Thumbnail?) in
           
            if let image = thumbnail?.image {
                self?.cache?.save(image, with: key as NSString)
                self?.icon.image = image
            }
        })
    }
}

