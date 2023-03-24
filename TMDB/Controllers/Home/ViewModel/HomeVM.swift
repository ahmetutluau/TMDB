//
//  HomeVM.swift
//  NetflixClone
//
//  Created by Ahmet Utlu on 1.03.2023.
//

import Foundation

enum HomeVMStateChange: StateChange {
    case getPopularSuccess
    case getTopRatedSuccess
    case getNowPlayingSuccess
    case getUpComingSuccess
    case networkFailure(String)
    
}

class HomeVM: StatefulVM<HomeVMStateChange> {
    let dataSource = HomeDS()
    
    //MARK: - Network Request

    func getPopularMovies() {
        Networking.request(router: MovieRouter.popular(1)) { (response: MoviesResponseModel?, errorString) in
            
            guard let results = response?.results else { return }
            
            self.dataSource.popularMovies = Array(results.prefix(10))
            self.emit(.getPopularSuccess)
            
        } onFailure: { (errorString, errorType) in
            guard let error = errorString else { return }
            
            self.emit(.networkFailure(error))
        }
    }
    
    func getTopRatedMovies() {
        Networking.request(router: MovieRouter.topRated(1)) { (response: MoviesResponseModel?, errorString) in
            
            guard let results = response?.results else { return }
            
            self.dataSource.topRatedMovies = Array(results.prefix(10))
            self.emit(.getTopRatedSuccess)
            
        } onFailure: { (errorString, errorType) in
            guard let error = errorString else { return }
            
            self.emit(.networkFailure(error))
        }
    }
    
    func getNowPlaying() {
        Networking.request(router: MovieRouter.nowPlaying) { (response: MoviesResponseModel?, errorString) in
            
            guard let results = response?.results else { return }
            
            self.dataSource.nowPlayingMovies = Array(results.prefix(10))
            self.emit(.getNowPlayingSuccess)
            
        } onFailure: { (errorString, errorType) in
            guard let error = errorString else { return }
            
            self.emit(.networkFailure(error))
        }
    }
    
    func getUpComing() {
        Networking.request(router: MovieRouter.upComing(1), shouldShowLoading: true) { (response: MoviesResponseModel?, errorString) in
            
            guard let results = response?.results else { return }
            
            self.dataSource.upComingMovies = Array(results.prefix(10))
            self.emit(.getUpComingSuccess)
            
        } onFailure: { (errorString, errorType) in
            guard let error = errorString else { return }
            
            self.emit(.networkFailure(error))
        }
    }
}
