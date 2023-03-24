//
//  ReadReviewsButton.swift
//  NetflixClone
//
//  Created by Ahmet Utlu on 9.03.2023.
//

import UIKit

class ReadReviewsButton: UIButton {
    
    lazy var buttonClicked: () -> () = {}

    lazy var buttonTitleLabel: BaseLabel = {
        let label = BaseLabel(text: .plain("Read All Reviews"),
                             textAlignment: .left,
                             numberOfLines: 1,
                             textColor: .white,
                             font: .systemFont(ofSize: 18, weight: .bold),
                             backgroundColor: .clear)
        
        return label
    }()
    
    lazy var leftImageView: BaseImageView = {
        let imageView = BaseImageView(image: UIImage(systemName: "list.bullet.rectangle.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal))
       
       imageView.contentMode = .scaleAspectFit
       imageView.backgroundColor = .clear
       
       return imageView
   }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews([leftImageView, buttonTitleLabel])
        
        leftImageView.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.leading).offset(CGFloat.dWidth * 20/735)
            make.centerY.equalToSuperview()
            make.width.equalTo(CGFloat.dWidth * 40/735)
            make.height.equalTo(CGFloat.dWidth * 35/735)
        }
        buttonTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(leftImageView.snp.trailing).offset(CGFloat.dWidth * 25/735)
            make.centerY.equalToSuperview()
        }
        
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        backgroundColor = .systemBlue
        self.layer.cornerRadius = CGFloat.dWidth * 25/735
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func buttonTapped() {
        buttonClicked()
    }
}
