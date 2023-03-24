//
//  ProfileVC.swift
//  NetflixClone
//
//  Created by Ahmet Utlu on 22.03.2023.
//

import UIKit

class ProfileVC: BaseVC {
    
    private lazy var backgroundContainerView: BaseView = {
        let view = BaseView(backgroundColor: ThemeColors.background2.color)
        
        view.clipsToBounds = true
        view.alpha = 0.7
        view.layer.cornerRadius = 40
        view.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        return view
    }()
    
    private lazy var profileImageView: BaseImageView = {
        let view = BaseImageView(image: nil,
                                 contentMode: .scaleAspectFill,
                                 backgroundColor: .gray)
        
        view.layer.masksToBounds = true
        view.layer.borderWidth = 1.5
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.cornerRadius = CGFloat.dHeight * (50/812)
        
        return view
    }()
    
    lazy var usernameLabel: BaseLabel = {
        let label = BaseLabel(text: .empty,
                             textAlignment: .center,
                             numberOfLines: 1,
                             textColor: .white,
                             font: .systemFont(ofSize: 12, weight: .regular),
                             backgroundColor: .clear)
                    
        return label
    }()
    
    lazy var nameLabel: BaseLabel = {
        let label = BaseLabel(text: .empty,
                             textAlignment: .center,
                             numberOfLines: 1,
                             textColor: .white,
                             font: .systemFont(ofSize: 30, weight: .bold),
                             backgroundColor: .clear)
        
        label.layer.cornerRadius = CGFloat.dWidth * 10/375
            
        return label
    }()
    
    private lazy var logoutButton: CustomButton = {
        let button = CustomButton(type: .center,
                                  title: "Logout",
                                  font: .systemFont(ofSize: 20, weight: .bold),
                                  titleColor: .white,
                                  backgroundColor: .systemRed,
                                  cornerRadius: CGFloat.dHeight * (30/812),
                                  isCenteredTitle: true)
        
        button.setColor(color: ThemeColors.background2.color)
        button.isButtonEnabled = true
        button.addTarget(self, action: #selector(tappedLogoutButton), for: .touchUpInside)

        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.isTranslucent = true
        title = "Profile"
        
        if let link = Defs.shared.defsUserModel?.avatar {
            ImageRequest.setImg(image: profileImageView, imgLink: "http://image.tmdb.org/t/p/w500\(link)")
        } else {
            profileImageView.image = UIImage(systemName: "person")
        }
        
        usernameLabel.text = Defs.shared.defsUserModel?.username
        nameLabel.text = Defs.shared.defsUserModel?.name
    }
    
    override func setupViews() {
        super.setupViews()
        
        view.addSubviews([backgroundContainerView,
                          profileImageView,
                          usernameLabel,
                          nameLabel,
                          logoutButton])
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        backgroundContainerView.snp.makeConstraints { make in
            make.top.trailing.leading.equalToSuperview()
            make.height.equalTo(CGFloat.dHeight * 3/5)
        }
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(CGFloat.dHeight * 0.08)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(CGFloat.dHeight * (100/812))
        }
        usernameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(CGFloat.dHeight * 10/812)
            make.centerX.equalToSuperview()
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(usernameLabel.snp.bottom).offset(CGFloat.dHeight * 20/812)
            make.centerX.equalToSuperview()
        }
        logoutButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-CGFloat.dHeight * 80/812)
            make.height.equalTo(CGFloat.dHeight * 60/812)
            make.leading.equalToSuperview().offset(CGFloat.dWidth * 30/375)
            make.trailing.equalToSuperview().offset(-CGFloat.dWidth * 30/375)
        }
    }
    
    @objc private func tappedLogoutButton() {
        Defs.shared.defsUserModel = nil
        let vc = SplashVC()
        self.setViewController(as: vc)
    }
    
}
