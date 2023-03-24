//
//  BiographyCell.swift
//  NetflixClone
//
//  Created by Ahmet Utlu on 14.03.2023.
//

import UIKit

class BiographyTableCell: BaseTableViewCell {
    
    private lazy var biographyLabel: BaseLabel = {
        let label = BaseLabel(text: .empty,
                              textAlignment: .left,
                              numberOfLines: .zero,
                              textColor: UIColor(white: 1, alpha: 0.9),
                              font: .systemFont(ofSize: 12, weight: .regular),
                              backgroundColor: .clear)
                    
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        
        contentView.addSubviews([biographyLabel])
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        biographyLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(CGFloat.dWidth * 20/735)
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(CGFloat.dWidth * 20/735)
            make.trailing.equalToSuperview().offset(-CGFloat.dWidth * 20/735)
        }
    }
    
    func setupCell(bio: String) {
        self.biographyLabel.text = bio
    }
}

