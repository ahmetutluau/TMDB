//
//  NowPlayingCollectionCell.swift
//  NetflixClone
//
//  Created by Ahmet Utlu on 5.03.2023.
//

import UIKit

class NowPlayingCollectionCell: BaseCollectionViewCell {
    
    private lazy var backgroundImageView: BaseImageView = {
        let view = BaseImageView(image: .none,
                                 contentMode: .scaleAspectFill,
                                 backgroundColor: .clear)
        
        view.layer.cornerRadius = CGFloat.dHeight * (10/812)
        view.clipsToBounds = true
        
        return view
    }()
    
    private lazy var posterContainerView: BaseView = {
        let view = BaseView(backgroundColor: .clear)
        
        view.dropShadow()
        view.dropShadows()
        view.addShadow()
        view.layer.cornerRadius = CGFloat.dHeight * (10/812)

        return view
    }()
    
    private lazy var posterImageView: BaseImageView = {
        let view = BaseImageView(image: .none,
                                 contentMode: .scaleAspectFill,
                                 backgroundColor: .clear)
        
        view.layer.cornerRadius = CGFloat.dHeight * (10/812)
        view.clipsToBounds = true
        
        return view
    }()
    
    private lazy var containerView: BaseView = {
        let view = BaseView(backgroundColor: .black)
        
        view.dropShadow()
        view.dropShadows()
        view.addShadow()
        view.alpha = 0.8
        
        return view
    }()
    
    private lazy var titleLabel: BaseLabel = {
        let label = BaseLabel(text: .empty,
                              textAlignment: .left,
                              numberOfLines: .zero,
                              textColor: .white,
                              font: .systemFont(ofSize: 12, weight: .bold),
                              backgroundColor: .clear)
        
        return label
    }()
    
    private lazy var subTitleLabel: BaseLabel = {
        let label = BaseLabel(text: .empty,
                              textAlignment: .left,
                              numberOfLines: 3,
                              textColor: .white,
                              font: .systemFont(ofSize: 10, weight: .regular),
                              backgroundColor: .clear)
        
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        
        contentView.addSubviews([backgroundImageView,
                                 posterContainerView,
                                 containerView])
        posterContainerView.addSubview(posterImageView)
        containerView.addSubviews([titleLabel,
                                   subTitleLabel])
        backgroundColor = .black
        clipsToBounds = true
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        posterContainerView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(CGFloat.dWidth * (5/375))
            make.bottom.equalToSuperview().offset(-CGFloat.dWidth * (5/375))
            make.height.equalTo(CGFloat.dHeight * (175/1500))
            make.width.equalTo(CGFloat.dWidth * (115/735))
        }
        posterImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        containerView.snp.makeConstraints { make in
            make.height.equalTo(CGFloat.dHeight * (90/1500))
            make.leading.equalTo(posterImageView.snp.trailing).offset(CGFloat.dWidth * (10/735))
            make.trailing.equalToSuperview().offset(-CGFloat.dWidth * (10/735))
            make.bottom.equalToSuperview().offset(-CGFloat.dHeight * (5/812))
        }
        titleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
    }
    
    func setCell(model: MoviesModel) {
        if let url = model.backdropPath {
            ImageRequest.setImg(image: backgroundImageView, imgLink: "http://image.tmdb.org/t/p/w500\(url)")
        }
        if let link = model.posterPath {
            ImageRequest.setImg(image: posterImageView, imgLink: "http://image.tmdb.org/t/p/w500\(link)")
        } else {
            posterImageView.image = UIImage(systemName: "person")
        }
        titleLabel.text = model.title
        subTitleLabel.text = model.overview
    }
}
