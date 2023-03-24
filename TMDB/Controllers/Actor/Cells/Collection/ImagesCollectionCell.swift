//
//  ImagesCollectionView.swift
//  NetflixClone
//
//  Created by Ahmet Utlu on 15.03.2023.
//

import UIKit

class ImagesCollectionCell: BaseCollectionViewCell {
    
    private lazy var imageView: BaseImageView = {
        let view = BaseImageView(image: nil,
                                 contentMode: .scaleAspectFill,
                                 backgroundColor: .clear)
        
        view.layer.cornerRadius = CGFloat.dHeight * (10/812)
        view.clipsToBounds = true
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 1
        
        return view
    }()
    
    override func setupViews() {
        super.setupViews()
        
        contentView.addSubview(imageView)
        backgroundColor = .black
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setCell(model: Profile) {
        if let link = model.filePath {
            ImageRequest.setImg(image: imageView, imgLink: "http://image.tmdb.org/t/p/w500\(link)")
        } else {
            imageView.image = UIImage(systemName: "person")
        }
    }
}
