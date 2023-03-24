//
//  BaseView.swift
//  NetflixClone
//
//  Created by Ahmet Utlu on 2.03.2023.
//

import UIKit

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupLayout()
    }
    
    /// Setup view and its subviews here.
    func setupViews() {
        backgroundColor = .white
    }
    
    /// Setup view and its subviews autolayout here.
    func setupLayout() {}
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(backgroundColor: UIColor?) {
        self.init()
        
        self.backgroundColor = backgroundColor
    }
}
