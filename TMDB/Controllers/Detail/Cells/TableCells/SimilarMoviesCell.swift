//
//  SimilarMoviesCell.swift
//  NetflixClone
//
//  Created by Ahmet Utlu on 10.03.2023.
//

import UIKit

protocol SimilarMoviesCellProtocol: AnyObject {
    func navigateToDetail(id: Int)
}

class SimilarMoviesCell: BaseTableViewCell {
    weak var delegate: SimilarMoviesCellProtocol?
    var movies = [MoviesModel]()
    
    private lazy var collectionView: BaseCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = CGFloat.dWidth * 10/735
        
        let collectionView = BaseCollectionView(layout: layout,
                                                cells: [MovieListCollectionCell.self,
                                                        NowPlayingCollectionCell.self],
                                                showsHorizontalScrollIndicator: false,
                                                backgroundColor: .clear)
                                                        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    override func setupViews() {
        super.setupViews()
        
        contentView.addSubview(collectionView)
        backgroundColor = .clear
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        collectionView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(CGFloat.dWidth * 20/735)
            make.trailing.equalToSuperview().offset(-CGFloat.dWidth * 20/735)
        }
    }
    
    func setupCell(movies: [MoviesModel]) {
        self.movies = movies
        self.collectionView.reloadData()
    }
}

extension SimilarMoviesCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieListCollectionCell.reuseIdentifier, for: indexPath) as! MovieListCollectionCell
        cell.setCell(model: movies[indexPath.row])
        return cell

    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = CGFloat.dWidth * (90/375)
        let height = CGFloat.dHeight * (180/812)
        return .init(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.navigateToDetail(id: movies[indexPath.row].id)
    }
}
