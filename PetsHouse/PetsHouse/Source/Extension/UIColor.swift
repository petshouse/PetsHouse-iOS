//
//  UIColor.swift
//  PetsHouse
//
//  Created by 문지수 on 2021/03/23.
//

import UIKit

extension UIColor {
    static func rgb(red: Int, green: Int, blue: Int, alpha: CGFloat) -> UIColor {
        return .init(red: CGFloat(red) / 255, green: CGFloat(green) / 255, blue: CGFloat(blue) / 255, alpha: alpha)
    }
    
    static var mainColor: UIColor {
        return rgb(red: 255, green: 153, blue: 204, alpha: 1)
    }
    
    static var subColor: UIColor {
        return rgb(red: 255, green: 157, blue: 140, alpha: 1)
    }
}
