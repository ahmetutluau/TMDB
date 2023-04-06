//
//  AllMoviesVM.swift
//  NetflixClone
//
//  Created by Ahmet Utlu on 6.03.2023.
//

import Foundation

enum AllMoviesVMStateChange: StateChange {
    case networkSuccess
    case networkFailure(String)
}

class AllMoviesVM: StatefulVM<AllMoviesVMStateChange> {
    let dataSource = AllMoviesDS()
    var page = 1
    var request: MovieType?
    
    //MARK: - Network Request

    func getPopularMovies() {
        Networking.request(router: MovieRouter.popular(page), shouldShowLoading: true) { (response: MoviesResponseModel?, errorString) in
            
            guard let results = response?.results else { return }
            
            self.dataSource.movies.append(contentsOf: results)
            self.page += 1
            self.emit(.networkSuccess)
            
        } onFailure: { (errorString, errorType) in
            guard let error = errorString else { return }
            
            self.emit(.networkFailure(error))
        }
    }
    
    func getTopRatedMovies() {
        Networking.request(router: MovieRouter.topRated(page), shouldShowLoading: true) { (response: MoviesResponseModel?, errorString) in
            
            guard let results = response?.results else { return }
            
            self.dataSource.movies.append(contentsOf: results)
            self.page += 1
            self.emit(.networkSuccess)
            
        } onFailure: { (errorString, errorType) in
            guard let error = errorString else { return }
            
            self.emit(.networkFailure(error))
        }
    }
    
    func getUpComing() {
        Networking.request(router: MovieRouter.upComing(page), shouldShowLoading: true) { (response: MoviesResponseModel?, errorString) in
            
            guard let results = response?.results else { return }
            
            self.dataSource.movies.append(contentsOf: results)
            self.page += 1
            self.emit(.networkSuccess)
            
        } onFailure: { (errorString, errorType) in
            guard let error = errorString else { return }
            
            self.emit(.networkFailure(error))
        }
    }
}

