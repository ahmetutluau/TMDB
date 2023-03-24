//
//  BaseCollectionViewCell.swift
//  NetflixClone
//
//  Created by Ahmet Utlu on 1.03.2023.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Setup cell and its subviews here.
    func setupViews() {
        backgroundColor = .white
    }
    
    /// Setup cell and its subviews autolayout here.
    func setupLayout() {}
    
}

extension BaseCollectionViewCell: Reuse {
    public static var reuseIdentifier: String {
        return String(describing: self)
    }
}
