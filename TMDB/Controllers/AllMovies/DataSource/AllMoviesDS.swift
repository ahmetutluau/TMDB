//
//  AllMoviesDS.swift
//  NetflixClone
//
//  Created by Ahmet Utlu on 6.03.2023.
//

import UIKit

enum AllMoviesDSStateChange: StateChange {
    case sendRequest
    case navigateToDetail(Int)
}

class AllMoviesDS: StatefulDS<AllMoviesDSStateChange> {
    var movies = [MoviesModel]()
    var actedMovies = [ActedMoviesModel]()
    var movieType: MovieType?
}

extension AllMoviesDS: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch movieType {
        case .actedMovies:
            return actedMovies.count
        default:
            return movies.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieListCollectionCell.reuseIdentifier, for: indexPath) as! MovieListCollectionCell
        switch movieType {
        case .actedMovies:
            cell.setCell(model: actedMovies[indexPath.row])
        default:
            cell.setCell(model: movies[indexPath.row], font: 12)
        }
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (CGFloat.dWidth - 30) / 2
        let height = CGFloat.dHeight * (300/812)
        return .init(width: width, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch movieType {
        case .actedMovies: self.emit(.navigateToDetail(actedMovies[indexPath.row].id))
        default: self.emit(.navigateToDetail(movies[indexPath.row].id))
        }
        
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
         let offsetY = scrollView.contentOffset.y
         let contentHeight = scrollView.contentSize.height
         let height = scrollView.frame.size.height

         if offsetY >= contentHeight - (2 * height) {
             self.emit(.sendRequest)
         }
     }
}
