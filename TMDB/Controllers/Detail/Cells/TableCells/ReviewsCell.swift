//
//  ReviewsCell.swift
//  NetflixClone
//
//  Created by Ahmet Utlu on 10.03.2023.
//

import UIKit

protocol ReviewsCellProtocol: AnyObject {
    func navigateToReviews(id: Int)
}

class ReviewsCell: BaseTableViewCell {
    weak var delegate: ReviewsCellProtocol?
    var id: Int?
    
    private lazy var button: ReadReviewsButton = {
        let button = ReadReviewsButton()
        
        button.buttonClicked = {
            guard let id = self.id else { return }
            self.delegate?.navigateToReviews(id: id)
        }
        
        return button
    }()
    
    override func setupViews() {
        super.setupViews()
        
        contentView.addSubview(button)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        button.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(CGFloat.dHeight * 10/735)
            make.trailing.equalToSuperview().offset(-CGFloat.dHeight * 10/735)
            make.height.equalTo(CGFloat.dHeight * 70/735)
            make.centerY.equalToSuperview()
        }
    }
    
    func setCell(id: Int) {
        self.id = id
    }
}
