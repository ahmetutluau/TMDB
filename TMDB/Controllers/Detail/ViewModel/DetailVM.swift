//
//  DetailVM.swift
//  NetflixClone
//
//  Created by Ahmet Utlu on 8.03.2023.
//

import Foundation

enum DetailVMStateChange: StateChange {
    case getDetailSuccess
    case getSimilarSuccess
    case getCreditsSuccess
    case getTrailersSuccess
    case networkFailure(String)
}

class DetailVM: StatefulVM<DetailVMStateChange> {
    let dataSource = DetailDS()
    
    //MARK: - Network Request

    func getMovieDetail(id: Int) {
        Networking.request(router: MovieRouter.detail(id), shouldShowLoading: true) { (response: DetailResponseModel?, errorString) in
            guard let response = response else { return }
            
            self.dataSource.movie = response
            self.emit(.getDetailSuccess)
            
        } onFailure: { (errorString, errorType) in
            guard let error = errorString else { return }
            
            self.emit(.networkFailure(error))
        }
    }
    
    func getSimilarMovies(id: Int) {
        Networking.request(router: MovieRouter.similar(id)) { (response: MoviesResponseModel?, errorString) in
            guard let results = response?.results else { return }
            
            self.dataSource.similarMovies = Array(results.prefix(20))
            self.emit(.getSimilarSuccess)
            
        } onFailure: { (errorString, errorType) in
            guard let error = errorString else { return }
            
            self.emit(.networkFailure(error))
        }
    }
    
    func getCredits(id: Int) {
        Networking.request(router: MovieRouter.credits(id)) { (response: CreditsResponseModel?, errorString) in
            guard let cast = response?.cast else { return }
            
            self.dataSource.cast = cast
            self.emit(.getCreditsSuccess)
            
        } onFailure: { (errorString, errorType) in
            guard let error = errorString else { return }
            
            self.emit(.networkFailure(error))
        }
    }
    
    func getTrailers(id: Int) {
        Networking.request(router: MovieRouter.videos(id)) { (response: TrailersResponseModel?, errorString) in
            guard let results = response?.results else { return }
            
            self.dataSource.trailers = results
            self.emit(.getTrailersSuccess)
            
        } onFailure: { (errorString, errorType) in
            guard let error = errorString else { return }
            
            self.emit(.networkFailure(error))
        }
    }
}
