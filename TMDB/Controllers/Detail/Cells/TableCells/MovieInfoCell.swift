//
//  DetailTableCell.swift
//  NetflixClone
//
//  Created by Ahmet Utlu on 8.03.2023.
//

import UIKit

class MovieInfoCell: BaseTableViewCell {
    var country = ""
    
    private lazy var containerView: BaseView = {
        let view = BaseView(backgroundColor: .clear)
        
        view.dropWhiteShadow()
        view.layer.cornerRadius = CGFloat.dHeight * (10/812)

        return view
    }()
    
    private lazy var posterImageView: BaseImageView = {
        let view = BaseImageView(image: .none,
                                 contentMode: .scaleAspectFill,
                                 backgroundColor: .clear)
        
        view.layer.cornerRadius = CGFloat.dHeight * (10/812)
        view.clipsToBounds = true
        
        return view
    }()
    
    private lazy var genresLabel: BaseLabel = {
        let label = BaseLabel(text: .empty,
                              textAlignment: .left,
                              numberOfLines: .zero,
                              textColor: .white,
                              font: .systemFont(ofSize: 16, weight: .bold),
                              backgroundColor: .clear)
        
        return label
    }()
    
    private lazy var imdbLabel: BaseLabel = {
        let label = BaseLabel(text: .empty,
                              textAlignment: .center,
                              numberOfLines: 1,
                              textColor: .white,
                              font: .systemFont(ofSize: 14, weight: .bold),
                              backgroundColor: .clear)
        
        label.layer.borderColor = UIColor.green.cgColor.copy(alpha: 0.6)
        label.layer.borderWidth = 2
        label.layer.cornerRadius = CGFloat.dWidth * (35/735)
        label.isHidden = true
        
        return label
    }()
    
    private lazy var languageLabel: BaseLabel = {
        let label = BaseLabel(text: .empty,
                              textAlignment: .center,
                              numberOfLines: 1,
                              textColor: .white,
                              font: .systemFont(ofSize: 16, weight: .bold),
                              backgroundColor: .clear)
        
        label.layer.borderColor = UIColor.green.cgColor.copy(alpha: 0.6)
        label.layer.borderWidth = 2
        label.isHidden = true
        
        return label
    }()
    
    private lazy var statusLabel: BaseLabel = {
        let label = BaseLabel(text: .plain("Status"),
                              textAlignment: .left,
                              numberOfLines: 1,
                              textColor: UIColor(white: 1, alpha: 0.9),
                              font: .systemFont(ofSize: 14, weight: .regular),
                              backgroundColor: .clear)
        
        label.isHidden = true
        
        return label
    }()
    
    private lazy var statusValueLabel: BaseLabel = {
        let label = BaseLabel(text: .empty,
                              textAlignment: .left,
                              numberOfLines: 1,
                              textColor: .green,
                              font: .systemFont(ofSize: 14, weight: .regular),
                              backgroundColor: .clear)
        label.alpha = 0.5
        
        return label
    }()
    
    private lazy var revenueLabel: BaseLabel = {
        let label = BaseLabel(text: .plain("Revenue"),
                              textAlignment: .left,
                              numberOfLines: 1,
                              textColor: UIColor(white: 1, alpha: 0.9),
                              font: .systemFont(ofSize: 14, weight: .regular),
                              backgroundColor: .clear)
        
        label.isHidden = true
        
        return label
    }()
    
    private lazy var revenueValueLabel: BaseLabel = {
        let label = BaseLabel(text: .empty,
                              textAlignment: .left,
                              numberOfLines: 1,
                              textColor: .green,
                              font: .systemFont(ofSize: 14, weight: .regular),
                              backgroundColor: .clear)
        label.alpha = 0.5
        
        return label
    }()
    
    private lazy var originalTitleLabel: BaseLabel = {
        let label = BaseLabel(text: .plain("Original title"),
                              textAlignment: .left,
                              numberOfLines: 1,
                              textColor: UIColor(white: 1, alpha: 0.9),
                              font: .systemFont(ofSize: 14, weight: .regular),
                              backgroundColor: .clear)
        
        return label
    }()
    
    private lazy var originalTitleValueLabel: BaseLabel = {
        let label = BaseLabel(text: .empty,
                              textAlignment: .left,
                              numberOfLines: 1,
                              textColor: .white,
                              font: .systemFont(ofSize: 14, weight: .bold),
                              backgroundColor: .clear)
        
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        
        contentView.addSubviews([containerView,
                                 genresLabel,
                                 imdbLabel,
                                 languageLabel,
                                 statusLabel,
                                 statusValueLabel,
                                 revenueLabel,
                                 revenueValueLabel,
                                 originalTitleLabel,
                                 originalTitleValueLabel])
        containerView.addSubview(posterImageView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        containerView.snp.makeConstraints { make in
            make.width.equalTo(CGFloat.dWidth * (270/735))
            make.height.equalTo(CGFloat.dHeight * (410/1500))
            make.leading.equalToSuperview().offset(CGFloat.dWidth * (40/735))
            make.top.equalToSuperview().offset(CGFloat.dWidth * (10/735))
        }
        posterImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        genresLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-CGFloat.dWidth * (20/735))
            make.leading.equalTo(posterImageView.snp.trailing).offset(CGFloat.dWidth * (20/735))
            make.top.equalToSuperview().offset(CGFloat.dWidth * (10/735))
        }
        imdbLabel.snp.makeConstraints { make in
            make.width.height.equalTo(CGFloat.dWidth * (70/735))
            make.leading.equalTo(posterImageView.snp.trailing).offset(CGFloat.dWidth * (20/735))
            make.top.equalTo(genresLabel.snp.bottom).offset(CGFloat.dWidth * (20/735))
        }
        languageLabel.snp.makeConstraints { make in
            make.width.height.equalTo(CGFloat.dWidth * (60/735))
            make.leading.equalTo(imdbLabel.snp.trailing).offset(CGFloat.dWidth * (20/735))
            make.centerY.equalTo(imdbLabel.snp.centerY)
        }
        statusLabel.snp.makeConstraints { make in
            make.leading.equalTo(posterImageView.snp.trailing).offset(CGFloat.dWidth * (20/735))
            make.top.equalTo(languageLabel.snp.bottom).offset(CGFloat.dWidth * (20/735))
        }
        statusValueLabel.snp.makeConstraints { make in
            make.leading.equalTo(posterImageView.snp.trailing).offset(CGFloat.dWidth * (20/735))
            make.top.equalTo(statusLabel.snp.bottom).offset(CGFloat.dWidth * (10/735))
        }
        revenueLabel.snp.makeConstraints { make in
            make.leading.equalTo(posterImageView.snp.trailing).offset(CGFloat.dWidth * (20/735))
            make.top.equalTo(statusValueLabel.snp.bottom).offset(CGFloat.dWidth * (20/735))
        }
        revenueValueLabel.snp.makeConstraints { make in
            make.leading.equalTo(posterImageView.snp.trailing).offset(CGFloat.dWidth * (20/735))
            make.top.equalTo(revenueLabel.snp.bottom).offset(CGFloat.dWidth * (10/735))
        }
        originalTitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(CGFloat.dWidth * (20/735))
            make.top.equalTo(posterImageView.snp.bottom).offset(CGFloat.dWidth * (20/735))
        }
        originalTitleValueLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(CGFloat.dWidth * (20/735))
            make.top.equalTo(originalTitleLabel.snp.bottom).offset(CGFloat.dWidth * (10/735))
        }
    }
    
    func setupCell(movie: DetailResponseModel) {
        if let countries = movie.productionCountries {
            for i in countries {
                if let country = i.iso3166 {
                    self.country = ",\(country)"
                }
            }
        }
        if let link = movie.posterPath {
            ImageRequest.setImg(image: posterImageView, imgLink: "http://image.tmdb.org/t/p/w500\(link)")
        }
        genresLabel.text = "\(movie.releaseDate?.prefix(4) ?? "")\(self.country),\(getGenresNames(movie))"
        imdbLabel.text = String(format:"%.1f", movie.voteAverage ?? 0.0)
        languageLabel.text = movie.originalLanguage?.uppercased()
        statusValueLabel.text = movie.status
        revenueValueLabel.text = "$\(movie.revenue ?? 0)"
        originalTitleValueLabel.text = movie.originalTitle
        
        imdbLabel.isHidden = false
        languageLabel.isHidden = false
        statusLabel.isHidden = false
        revenueLabel.isHidden = false
    }
    
    private func getGenresNames(_ movie: DetailResponseModel) -> String {
        var genresList = [String]()
        var genresString = ""
        if let genres = movie.genres {
            for i in genres {
                genresList.append(i.name ?? "")
            }
            genresString = genresList.joined(separator: ",")
        }
        return genresString
    }
}


