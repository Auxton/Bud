//
//  ExtensionCommons.swift
//  Bud
//
//  Created by Austin Odiadi on 15/08/2018.
//  Copyright © 2018 Austin Odiadi. All rights reserved.
//

import UIKit
import Foundation

public extension UIView {
    
    func instantiateNib<T : UIView>() -> T? {
        guard let view = Bundle.main.loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?[0] as? T else {
            return nil
        }
        
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let views = ["view": view]
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat:"H:|[view]|", options: [], metrics:nil, views:views))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat:"V:|[view]|", options: [], metrics:nil, views:views))
        
        return view
    }
}

public extension UIImageView {
    func circleWithBorder(borderColor: UIColor, strokeWidth: CGFloat)
    {
        var radius = min(self.bounds.width, self.bounds.height)
        var frame : CGRect = self.bounds
        frame.size.width = radius
        frame.origin.x = (self.bounds.size.width - radius) / 2
        frame.size.height = radius
        frame.origin.y = (self.bounds.size.height - radius) / 2
        
        radius /= 2
        
        
        var path = UIBezierPath(roundedRect: frame.insetBy(dx: strokeWidth/2, dy: strokeWidth/2), cornerRadius: radius)
        let border = CAShapeLayer()
        border.fillColor = UIColor.clear.cgColor
        border.path = path.cgPath
        border.strokeColor = borderColor.cgColor
        border.lineWidth = strokeWidth
        self.layer.addSublayer(border)
        
        path = UIBezierPath(roundedRect: frame, cornerRadius: radius)
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
    
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        
        getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        
        return String(format:"#%06x", rgb)
    }
}
