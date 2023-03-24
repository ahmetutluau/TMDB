//
//  OverViewCell.swift
//  NetflixClone
//
//  Created by Ahmet Utlu on 10.03.2023.
//

import UIKit

class OverViewCell: BaseTableViewCell {
    private lazy var tagLineLabel: BaseLabel = {
        let label = BaseLabel(text: .empty,
                              textAlignment: .left,
                              numberOfLines: .zero,
                              textColor: UIColor(white: 1, alpha: 0.6),
                              font: .systemFont(ofSize: 10, weight: .regular),
                              backgroundColor: .clear)
        
        return label
    }()
    
    private lazy var overviewLabel: BaseLabel = {
        let label = BaseLabel(text: .empty,
                              textAlignment: .left,
                              numberOfLines: .zero,
                              textColor: UIColor(white: 1, alpha: 0.9),
                              font: .systemFont(ofSize: 12, weight: .regular),
                              backgroundColor: .clear,
                              adjustsFontSizeToFitWidth: false)
                    
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        
        contentView.addSubviews([tagLineLabel,
                                 overviewLabel])
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        tagLineLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(CGFloat.dWidth * 10/735)
            make.trailing.equalToSuperview()
            make.leading.equalToSuperview().offset(CGFloat.dWidth * 20/735)
        }
        overviewLabel.snp.makeConstraints { make in
            make.top.equalTo(tagLineLabel.snp.bottom).offset(CGFloat.dWidth * 20/735)
            make.bottom.equalToSuperview()
            make.trailing.equalToSuperview().offset(-CGFloat.dWidth * 20/735)
            make.leading.equalToSuperview().offset(CGFloat.dWidth * 20/735)
        }
    }
    
    func setupCell(movie: DetailResponseModel) {
        self.tagLineLabel.text = movie.tagline
        self.overviewLabel.text = movie.overview
    }
}

