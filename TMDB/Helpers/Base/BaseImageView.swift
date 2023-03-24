//
//  BaseImageView.swift
//  NetflixClone
//
//  Created by Ahmet Utlu on 2.03.2023.
//

import UIKit

class BaseImageView: UIImageView {

    override init(image: UIImage?) {
        super.init(image: image)
        
        setupViews()
        setupLayout()
    }
    
    /// Setup view and its subviews here.
    func setupViews() {
        backgroundColor = .white
    }
    
    /// Setup view and its subviews autolayout here.
    func setupLayout() {}
    
    convenience init(
        image: UIImage?,
        contentMode: UIView.ContentMode,
        backgroundColor: UIColor? = .white) {
        
        self.init(image: image)
        
        self.contentMode = contentMode
        self.backgroundColor = backgroundColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
