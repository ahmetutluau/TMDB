//
//  HomeMovieCell.swift
//  NetflixClone
//
//  Created by Ahmet Utlu on 1.03.2023.
//

import UIKit
import SnapKit

protocol HomeTableCellProtocol: AnyObject {
    func pushToDetail(id: Int)
}

class HomeTableCell: BaseTableViewCell {
    
    weak var delegate: HomeTableCellProtocol?
    var movies = [MoviesModel]()
    var section: Int?
    private let margin = CGFloat.dWidth * (20/735)
    
    private lazy var collectionView: BaseCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = CGFloat.dWidth * (10/735)
        layout.sectionInset = .init(top: 0, left: margin, bottom: 0, right: margin)
        
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
        contentView.addSubview(collectionView)
        backgroundColor = .clear
    }
    
    override func setupLayout() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setCell(movies: [MoviesModel], section: Int) {
        self.movies = movies
        self.section = section
        self.collectionView.reloadData()
    }
}

extension HomeTableCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if section == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NowPlayingCollectionCell.reuseIdentifier, for: indexPath) as! NowPlayingCollectionCell
            cell.setCell(model: movies[indexPath.row])
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieListCollectionCell.reuseIdentifier, for: indexPath) as! MovieListCollectionCell
            cell.setCell(model: movies[indexPath.row])
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if section == 2 {
            let width = CGFloat.dWidth * (535/735)
            let height = CGFloat.dHeight * (380/1500)
            return .init(width: width, height: height)
        } else {
            let width = CGFloat.dWidth * (205/735)
            let height = CGFloat.dHeight * (350/1500)
            return .init(width: width, height: height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if section != 2 {
            self.delegate?.pushToDetail(id: movies[indexPath.row].id)
        }
    }
    
}
