//
//  UILabel.swift
//  PetsHouse
//
//  Created by 문지수 on 2021/11/29.
//

import UIKit

extension UILabel {
    func setLineSpacing(lineSpacing: CGFloat = 0.0, lineHeightMultiple: CGFloat = 0.0) {

           guard let labelText = self.text else { return }

           let paragraphStyle = NSMutableParagraphStyle()
           paragraphStyle.lineSpacing = lineSpacing
           paragraphStyle.lineHeightMultiple = lineHeightMultiple

           let attributedString:NSMutableAttributedString
           if let labelattributedText = self.attributedText {
               attributedString = NSMutableAttributedString(attributedString: labelattributedText)
           } else {
               attributedString = NSMutableAttributedString(string: labelText)
           }

           attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        
           self.attributedText = attributedString
       }
}
