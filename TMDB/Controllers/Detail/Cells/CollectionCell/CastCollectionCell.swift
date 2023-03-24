//
//  CastCollectionCell.swift
//  NetflixClone
//
//  Created by Ahmet Utlu on 10.03.2023.
//

import UIKit

class CastCollectionCell: BaseCollectionViewCell {
    
    private lazy var imageView: BaseImageView = {
        let view = BaseImageView(image: .none,
                                 contentMode: .scaleAspectFill,
                                 backgroundColor: .clear)
        
        view.clipsToBounds = true
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.white.cgColor
        
        return view
    }()
    
    private lazy var titleLabel: BaseLabel = {
        let label = BaseLabel(text: .empty,
                              textAlignment: .center,
                              numberOfLines: .zero,
                              textColor: .white,
                              font: .systemFont(ofSize: 11, weight: .bold),
                              backgroundColor: .clear)
        
        return label
    }()
    
    private lazy var subTitleLabel: BaseLabel = {
        let label = BaseLabel(text: .empty,
                              textAlignment: .left,
                              numberOfLines: .zero,
                              textColor: UIColor(white: 1, alpha: 0.9),
                              font: .systemFont(ofSize: 10, weight: .regular),
                              backgroundColor: .clear)

        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        
        contentView.addSubviews([imageView,
                                titleLabel,
                                subTitleLabel])
        backgroundColor = .clear
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(CGFloat.dHeight * (250/1500))
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
        }
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
        }
    }
    
    func setCell(model: Cast) {
        if let link = model.profilePath {
            ImageRequest.setImg(image: imageView, imgLink: "http://image.tmdb.org/t/p/w500\(link)")
        }
        titleLabel.text = model.name
        subTitleLabel.text = model.character
    }
}
