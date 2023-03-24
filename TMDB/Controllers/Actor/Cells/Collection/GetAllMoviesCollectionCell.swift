//
//  GetAllMoviesCell.swift
//  NetflixClone
//
//  Created by Ahmet Utlu on 15.03.2023.
//

import UIKit
protocol GetAllMoviesCellProtocol: AnyObject {
    func navigateToAll()
}

class GetAllMoviesCollectionCell: BaseCollectionViewCell {
    weak var delegate: GetAllMoviesCellProtocol?
    
    private lazy var goButton: UIButton = {
        let button = UIButton()
        
        button.imageView?.contentMode = .scaleAspectFill
        button.setImage(UIImage(systemName: "rectangle.portrait.and.arrow.right.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(tappedBackbutton), for: .touchUpInside)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = CGFloat.dWidth * 30/735
        button.clipsToBounds = true
        
        return button
    }()
    
    override func setupViews() {
        super.setupViews()
        
        contentView.addSubview(goButton)
        backgroundColor = .black
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        goButton.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-CGFloat.dHeight * (20/812))
        }
    }
    
    @objc private func tappedBackbutton() {
        delegate?.navigateToAll()
    }
}
 
