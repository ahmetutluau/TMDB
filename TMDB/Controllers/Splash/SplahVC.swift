//
//  SplahVC.swift
//  NetflixClone
//
//  Created by Ahmet Utlu on 22.03.2023.
//

import UIKit

class SplashVC: BaseVC {
    
    let viewModel = SplashVM()
    
    private lazy var backGroundImageView: BaseImageView = {
        let imageView = BaseImageView(image: UIImage(named: "splashIcon"))
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.viewModel.handleNav()
        }
    }
    
    override func setupViews() {
        super.setupViews()
        view.addSubview(backGroundImageView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        backGroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func navigateToOnboarding() {
        let vc = LoginVC()
        self.setViewController(as: vc)
        
    }
    
    private func navigateToHome() {
        let vc = HomeVC()
        self.setViewController(as: vc)
    }
}

extension SplashVC {
    override func observeViewModel() {
        super.observeViewModel()
        
        self.viewModel.subscribe { [weak self] state in
            guard let self = self else { return }
            
            switch state {
            case .handleAuthorized:
                self.navigateToHome()
            case .handleNotAuthorized:
                self.navigateToOnboarding()
            }
        }
    }
}
