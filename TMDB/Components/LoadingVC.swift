//
//  LoadingVC.swift
//  NetflixClone
//
//  Created by Ahmet Utlu on 24.03.2023.
//

import UIKit

class LoadingVC: BaseVC {
    
    var lottieType: LottieType = .loading
    
    lazy var lottieView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView(style: .large)
        indicatorView.isHidden = true
        indicatorView.color = .white
        
        return indicatorView
    }()
    
    private lazy var backGround: BaseView = {
        let view = BaseView(backgroundColor: .clear)
        view.backgroundColor = .black.withAlphaComponent(0.3)
        
        return view
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupLottieView(for: lottieType)
    }
    
    override func setupViews() {
        view.backgroundColor = .clear
        view.addSubview(lottieView)
        view.addSubview(backGround)
        view.addSubview(activityIndicator)
    }
    
    override func setupLayout() {
        lottieView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(200)
        }
        backGround.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalToSuperview()
        }
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(100)
        }
        activityIndicator.startAnimating()
    }
    
    fileprivate func setupLottieView(for lottieType: LottieType) {
        let animationView = LottieManager.shared.getLottieView(toView: lottieView,
                                                               lottieType: lottieType,
                                                               contentMode: .scaleAspectFill,
                                                               loopMode: .loop,
                                                               shouldPlay: true)
        lottieView.addSubview(animationView)
        animationView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        animationView.play()
    }
    
}
