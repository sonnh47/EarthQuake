//
//  CustomLabel.swift
//  EarthQuake
//
//  Created by Son on 11/19/18.
//  Copyright © 2018 NguyenHoangSon. All rights reserved.
//

import Foundation
import UIKit
extension UIView {

    @IBInspectable var cornerRadius: CGFloat {
        get {
            return CGFloat(tag)
        }
        set {
            layer.cornerRadius = newValue
            tag = Int(newValue)
            if newValue == -1 {
                self.clipsToBounds = true
                self.layer.cornerRadius = self.bounds.width < self.bounds.height ? self.bounds.width * 0.5 : self.bounds.height * 0.5
            } else {
                layer.masksToBounds = true
            }
        }
    }

}

@IBDesignable

class Label: UILabel {
    override func layoutSubviews() {
        super.layoutSubviews()
        if cornerRadius == -1 {
            self.layer.cornerRadius = self.bounds.width < self.bounds.height ? self.bounds.width * 0.5 : self.bounds.height * 0.5
        }
    }
}
//class Label: UILabel {
//    
//    required init(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)!
//        self.commonInit()
//        
//    }
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        self.commonInit()
//    }
//    func commonInit(){
//        self.layer.cornerRadius = self.bounds.width/2
//        self.clipsToBounds = true
//        self.textColor = UIColor.white
//        self.setProperties(borderWidth: 1.0, borderColor:UIColor.gray)
//    }
//    func setProperties(borderWidth: Float, borderColor: UIColor) {
//        self.layer.borderWidth = CGFloat(borderWidth)
//        self.layer.borderColor = borderColor.cgColor
//    }
//}

