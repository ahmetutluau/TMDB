//
//  ReviewsTableCell.swift
//  NetflixClone
//
//  Created by Ahmet Utlu on 14.03.2023.
//

import UIKit

class ReviewsDetailTableCell: BaseTableViewCell {
    
    private lazy var containerView: BaseView = {
        let view = BaseView(backgroundColor: .white)
        
        view.layer.cornerRadius = CGFloat.dWidth * 20/735
        view.clipsToBounds = true
        
        return view
    }()
    
    private lazy var profileImageView: BaseImageView = {
        let view = BaseImageView(image: nil,
                                 contentMode: .scaleAspectFill,
                                 backgroundColor: .clear)
        
        view.layer.cornerRadius = CGFloat.dHeight * (30/735)
        view.clipsToBounds = true
        
        return view
    }()
    
    private lazy var authorLabel: BaseLabel = {
        let label = BaseLabel(text: .empty,
                              textAlignment: .left,
                              numberOfLines: 1,
                              textColor: .black,
                              font: .systemFont(ofSize: 16, weight: .bold),
                              backgroundColor: .clear)
        
        return label
    }()
    
    private lazy var ratingContainerView: BaseView = {
        let view = BaseView(backgroundColor: .black)
        
        view.layer.cornerRadius = CGFloat.dWidth * 15/735
        
        return view
    }()
    
    private lazy var starImageView: BaseImageView = {
        let view = BaseImageView(image: UIImage(systemName: "star.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal),
                                 contentMode: .scaleAspectFill,
                                 backgroundColor: .clear)
        
        view.layer.cornerRadius = CGFloat.dHeight * (10/812)
        view.clipsToBounds = true
        
        return view
    }()
    
    private lazy var ratingLabel: BaseLabel = {
        let label = BaseLabel(text: .empty,
                              textAlignment: .left,
                              numberOfLines: 1,
                              textColor: .white,
                              font: .systemFont(ofSize: 14, weight: .regular),
                              backgroundColor: .clear)
        
        return label
    }()
    
    private lazy var detailLabel: BaseLabel = {
        let label = BaseLabel(text: .empty,
                              textAlignment: .left,
                              numberOfLines: 1,
                              textColor: .black,
                              font: .systemFont(ofSize: 8, weight: .regular),
                              backgroundColor: .clear)
        
        return label
    }()
    
    private lazy var contentLabel: BaseLabel = {
        let label = BaseLabel(text: .plain(""),
                              textAlignment: .left,
                              numberOfLines: .zero,
                              textColor: .black,
                              font: .systemFont(ofSize: 14, weight: .regular),
                              backgroundColor: .clear)
        
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        contentView.layer.cornerRadius = CGFloat.dWidth * 20/735
        contentView.clipsToBounds = true
        
        contentView.addSubview(containerView)
        containerView.addSubviews([profileImageView,
                                authorLabel,
                                ratingContainerView,
                                detailLabel,
                                contentLabel])
        
        ratingContainerView.addSubviews([starImageView,
                                      ratingLabel])
    }
    
    override func setupLayout() {
        super.setupLayout()
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(CGFloat.dWidth * 10/735)
            make.trailing.bottom.equalToSuperview().offset(-CGFloat.dWidth * 10/735)
        }
        profileImageView.snp.makeConstraints { make in
            make.height.width.equalTo(CGFloat.dWidth * 120/735)
            make.leading.top.equalToSuperview().offset(CGFloat.dWidth * 15/735)
        }
        authorLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(CGFloat.dWidth * 15/735)
            make.leading.equalTo(profileImageView.snp.trailing).offset(CGFloat.dWidth * 20/735)
            make.trailing.equalToSuperview().offset(-CGFloat.dWidth * 10/735)
        }
        ratingContainerView.snp.makeConstraints { make in
            make.top.equalTo(authorLabel.snp.bottom).offset(CGFloat.dWidth * 20/735)
            make.leading.equalTo(profileImageView.snp.trailing).offset(CGFloat.dWidth * 20/735)
            make.width.equalTo(CGFloat.dWidth * 110/735)
            make.height.equalTo(CGFloat.dWidth * 40/735)
        }
        starImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(CGFloat.dWidth * 5/735)
            make.height.width.equalTo(CGFloat.dWidth * 30/735)
        }
        ratingLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(starImageView.snp.trailing).offset(CGFloat.dWidth * 10/735)
        }
        detailLabel.snp.makeConstraints { make in
            make.top.equalTo(ratingContainerView.snp.bottom).offset(CGFloat.dWidth * 15/735)
            make.leading.equalTo(profileImageView.snp.trailing).offset(CGFloat.dWidth * 20/735)
        }
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(detailLabel.snp.bottom).offset(CGFloat.dWidth * 15/735)
            make.leading.equalTo(profileImageView.snp.trailing).offset(CGFloat.dWidth * 20/735)
            make.trailing.equalToSuperview().offset(-CGFloat.dWidth * 10/735)
            make.bottom.equalToSuperview().offset(-CGFloat.dWidth * 15/735)
        }
    }
    
    func setCell(model: ReviewsModel) {
        if let link = model.authorDetails?.avatarPath {
            ImageRequest.setImg(image: profileImageView, imgLink: "http://image.tmdb.org/t/p/w500\(link)")
        } else {
            profileImageView.image = UIImage(systemName: "person")
        }
        
        authorLabel.text = "A review by \(model.author ?? "unkown")"
        if let rate = model.authorDetails?.rating {
            ratingLabel.text = String(format: "%.1f", rate)
        }
        if let date = model.updatedAt?.toDate(withFormat: "yyyy'-'MM'-'dd'T'HH':'mm':'ss") {
            let str = date.toString(withFormat: "MMM d, yyyy")
            detailLabel.text = "written by on \(model.author ?? "") \(str)"
        }
        contentLabel.text = model.content?.htmlToString
//        contentLabel.text = "\(model.content?.htmlToString.substring(from: "**", to: "**") ?? "")\n\n\(model.content?.htmlToString.substring(from: ".**", to: "") ?? "")"
    }
}
