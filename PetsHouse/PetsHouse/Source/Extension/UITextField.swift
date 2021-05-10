//
//  UITextField.swift
//  PetsHouse
//
//  Created by 문지수 on 2021/05/10.
//

import Foundation
import UIKit

extension UITextField {
    func underLine() {
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.black.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}
