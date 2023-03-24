//
//  SearchDS.swift
//  NetflixClone
//
//  Created by Ahmet Utlu on 5.03.2023.
//

import UIKit

enum SearchDSStateChange: StateChange {
    case pushToDetail(Int)
    
}

class SearchDS: StatefulDS<SearchDSStateChange> {
    var searchedMovies = [MoviesModel]()

}

extension SearchDS : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        searchedMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieListCollectionCell.reuseIdentifier, for: indexPath) as! MovieListCollectionCell
        cell.setCell(model: searchedMovies[indexPath.row], font: 12)
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (CGFloat.dWidth - 30) / 2
        let height = CGFloat.dHeight * (300/812)
        return .init(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.emit(.pushToDetail(searchedMovies[indexPath.row].id))
    }
}
