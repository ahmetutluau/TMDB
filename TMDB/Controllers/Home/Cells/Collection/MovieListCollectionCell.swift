//
//  HomeCollectionCell.swift
//  NetflixClone
//
//  Created by Ahmet Utlu on 3.03.2023.
//

import UIKit

class MovieListCollectionCell: BaseCollectionViewCell {
    
    private lazy var imageView: BaseImageView = {
        let view = BaseImageView(image: .none,
                                 contentMode: .scaleAspectFill,
                                 backgroundColor: .clear)
        
        view.layer.cornerRadius = CGFloat.dHeight * (10/812)
        view.clipsToBounds = true
        
        return view
    }()
    
    private lazy var titleLabel: BaseLabel = {
        let label = BaseLabel(text: .empty,
                              textAlignment: .center,
                              numberOfLines: .zero,
                              textColor: .white,
                              font: .systemFont(ofSize: 8, weight: .bold),
                              backgroundColor: .clear)
        
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        backgroundColor = .clear
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-CGFloat.dHeight * 50/1500)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
        }
    }
    
    func setCell(model: MoviesModel, font: CGFloat = 10) {
        if let link = model.posterPath {
            ImageRequest.setImg(image: imageView, imgLink: "http://image.tmdb.org/t/p/w500\(link)")
        } else {
            imageView.image = UIImage(systemName: "person")
        }
        titleLabel.text = model.title
        titleLabel.font = .systemFont(ofSize: font, weight: .bold)
    }
    
    func setCell(model: ActedMoviesModel,font: CGFloat = 14) {
        if let link = model.posterPath {
            ImageRequest.setImg(image: imageView, imgLink: "http://image.tmdb.org/t/p/w500\(link)")
        }
        titleLabel.text = model.title
        titleLabel.font = .systemFont(ofSize: font, weight: .bold)
    }
}
