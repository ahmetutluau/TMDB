//
//  TrailerCollectionCell.swift
//  NetflixClone
//
//  Created by Ahmet Utlu on 13.03.2023.
//

import UIKit

protocol TrailerCollectionCellProtocol: AnyObject {
    func pushVC(url: String)
}

class TrailerCollectionCell: BaseCollectionViewCell {
    weak var delegate: TrailerCollectionCellProtocol?
    var trailer: TrailerModel?
    
    private lazy var backGroundImageView: BaseImageView = {
        let view = BaseImageView(image: .none,
                                 contentMode: .scaleAspectFill,
                                 backgroundColor: .clear)
        
        view.clipsToBounds = true
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.orange.cgColor.copy(alpha: 0.8)
        view.layer.cornerRadius = CGFloat.dWidth * 10/735
        addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                    action: #selector(selectImageTapped)))
        
        return view
    }()
    
    private lazy var playContainerView: BaseView = {
        let view = BaseView(backgroundColor: .black)
        
        view.dropShadow()
        view.addShadow()
        view.dropShadows()
        view.alpha = 0.7
        view.layer.cornerRadius = CGFloat.dWidth * 60/735
        
        return view
    }()
    
    private lazy var playImageView: BaseImageView = {
        let view = BaseImageView(image: UIImage(systemName: "play.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal),
                                 contentMode: .scaleAspectFill,
                                 backgroundColor: .clear)
        
        return view
    }()
    
    override func setupViews() {
        contentView.addSubviews([backGroundImageView,
                                playContainerView])
        playContainerView.addSubview(playImageView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        backGroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        playContainerView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.width.equalTo(CGFloat.dWidth * 120/735)
        }
        playImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.width.equalTo(CGFloat.dWidth * 50/735)
        }
    }
    
    func setCell(trailer: TrailerModel) {
        if let link = trailer.key {
            ImageRequest.setImg(image: backGroundImageView, imgLink: "https://img.youtube.com/vi/\(link)/hqdefault.jpg")
        }
        self.trailer = trailer
    }
    
    @objc private func selectImageTapped(_ sender: UITapGestureRecognizer?) {
        guard let trailer = trailer else { return }
        DispatchQueue.main.async {
            guard let key = trailer.key else { return }
            self.delegate?.pushVC(url: "http://www.youtube.com/watch?v=\(key)")
        }
        
    }
}
