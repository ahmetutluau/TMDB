//
//  ActedMoviesCell.swift
//  NetflixClone
//
//  Created by Ahmet Utlu on 14.03.2023.
//

import UIKit
protocol ActedMoviesCellProtocol: AnyObject {
    func navigateToDetail(id: Int)
    func navigateToAll()
}

class ActedMoviesTableCell: BaseTableViewCell {
    weak var delegate: ActedMoviesCellProtocol?
    var movies = [ActedMoviesModel]()
    
    private lazy var collectionView: BaseCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
//        layout.minimumLineSpacing = CGFloat.dWidth * 10/735
        
        let collectionView = BaseCollectionView(layout: layout,
                                                cells: [MovieListCollectionCell.self,
                                                        GetAllMoviesCollectionCell.self],
                                                showsHorizontalScrollIndicator: false,
                                                backgroundColor: .clear)
                                                        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    override func setupViews() {
        contentView.addSubview(collectionView)
        backgroundColor = .black
    }
    
    override func setupLayout() {
        collectionView.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(CGFloat.dWidth * 20/735)
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(CGFloat.dWidth * 20/735)
            make.trailing.equalToSuperview().offset(-CGFloat.dWidth * 20/735)
        }
    }
    
    func setCell(movies: [ActedMoviesModel]) {
        self.movies = movies
        self.collectionView.reloadData()
    }
}

extension ActedMoviesTableCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movies.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == movies.count {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GetAllMoviesCollectionCell.reuseIdentifier, for: indexPath) as! GetAllMoviesCollectionCell
            cell.delegate = self
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieListCollectionCell.reuseIdentifier, for: indexPath) as! MovieListCollectionCell
            cell.setCell(model: movies[indexPath.row], font: 10)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.row == movies.count {
            let width = CGFloat.dWidth * (45/375)
            let height = CGFloat.dHeight * (180/812)
            return .init(width: width, height: height)
        } else {
            let width = CGFloat.dWidth * (90/375)
            let height = CGFloat.dHeight * (180/812)
            return .init(width: width, height: height)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.navigateToDetail(id: movies[indexPath.row].id)
    }
    
}

extension ActedMoviesTableCell: GetAllMoviesCellProtocol {
    func navigateToAll() {
        delegate?.navigateToAll()
    }
}
