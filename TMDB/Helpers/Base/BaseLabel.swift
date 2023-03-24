//
//  BaseLabel.swift
//  NetflixClone
//
//  Created by Ahmet Utlu on 2.03.2023.
//

import UIKit

class BaseLabel: UILabel {
    
    convenience init(
        text: TextType,
        textAlignment: NSTextAlignment = .natural,
        numberOfLines: Int = 1,
        textColor: UIColor? = .black,
        font: UIFont? = nil,
        backgroundColor: UIColor? = .white,
        minimumScaleFactor: CGFloat = 1.0,
        lineBreakMode: NSLineBreakMode = .byTruncatingTail,
        adjustsFontSizeToFitWidth: Bool = false) {
            
            self.init()
            
            
            switch text {
            case .plain(let string):
                self.text = string
            case .attributed(let attributedText):
                self.attributedText = attributedText
            case .empty:
                self.attributedText = nil
                self.text = nil
            }
            
            self.textAlignment = textAlignment
            self.numberOfLines = numberOfLines
            self.textColor = textColor
            self.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth
            self.lineBreakMode = lineBreakMode
            
            if let aFont = font {
                self.font = aFont
            }
            
            if minimumScaleFactor < 1 {
                self.adjustsFontSizeToFitWidth = true
                self.minimumScaleFactor = minimumScaleFactor
            }
            
            self.backgroundColor = backgroundColor
        }
}
