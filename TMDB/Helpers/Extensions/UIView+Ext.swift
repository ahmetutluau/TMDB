//
//  UIView+Ext.swift
//  NetflixClone
//
//  Created by Ahmet Utlu on 5.03.2023.
//

import UIKit

extension UIView {
    func addSubviews(_ subviews: [UIView]) {
        subviews.forEach { addSubview($0) }
    }
    
    func addShadow(ofColor color: UIColor = .black, radius: CGFloat = 8, offset: CGSize = .zero, opacity: Float = 0.8) {
        layer.shadowRadius = radius
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowOpacity = opacity
        layer.masksToBounds = false
    }
    
    func dropShadow() {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        backgroundColor = UIColor.black
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = 0.9
        layer.shadowRadius = 8
    }
    
    func dropShadows(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.9
        layer.shadowOffset = CGSize(width: 0, height: 2.0)
        layer.shadowRadius = 8
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    func dropWhiteShadow() {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.white.cgColor
//        backgroundColor = UIColor.white
        layer.shadowOffset = CGSize(width: 0, height: 0)
//        layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius).cgPath

        layer.shadowOpacity = 0.3
        layer.shadowRadius = 7
    }
    
    func removeSubviews() {
        subviews.forEach({ $0.removeFromSuperview() })
    }
}
