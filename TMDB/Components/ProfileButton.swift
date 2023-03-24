//
//  ProfileButton.swift
//  NetflixClone
//
//  Created by Ahmet Utlu on 22.03.2023.
//

import UIKit

class ProfileButton: UIButton {
    
    lazy var profileImageView: BaseImageView = {
        let view = BaseImageView(image: nil,
                                 contentMode: .scaleToFill,
                               backgroundColor: .clear)
        
        view.clipsToBounds = true
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.cornerRadius = CGFloat.dWidth * 14/375
        
        return view
    }()
    
    convenience init(profileImage: UIImage? = nil) {
        self.init()
        
        addSubviews([profileImageView])
        
        self.profileImageView.image = profileImage
        
        self.profileImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.height.equalTo(CGFloat.dWidth * 28/375)
        }
    }
}
