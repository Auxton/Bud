//
//  Thumbnail.swift
//  Bud
//
//  Created by Austin Odiadi on 16/08/2018.
//  Copyright © 2018 Austin Odiadi. All rights reserved.
//

import UIKit
import Foundation

struct Thumbnail {
    let image: UIImage?
}

extension Thumbnail: JSONDecodable {
    
    init?(data: JSON) {
        guard data is Data else { return nil}
        
        image = UIImage(data: data as! Data)
    }
}

