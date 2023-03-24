//
//  BaseTableViewCell.swift
//  NetflixClone
//
//  Created by Ahmet Utlu on 1.03.2023.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Setup cell and its subviews here.
    func setupViews() {
        backgroundColor = .clear
        selectionStyle = .none
    }
    
    /// Setup cell and its subviews autolayout here.
    func setupLayout() {}
    
    
}

extension BaseTableViewCell: Reuse {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
