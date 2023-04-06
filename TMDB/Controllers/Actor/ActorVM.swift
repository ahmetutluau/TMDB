//
//  ActorVM.swift
//  NetflixClone
//
//  Created by Ahmet Utlu on 14.03.2023.
//

import Foundation

enum ActorVMStateChange: StateChange {
    case getDetailSuccess
    case getActedMoviesSuccess
    case getImagesSuccess
    case networkFailure(String)
}

class ActorVM: StatefulVM<ActorVMStateChange> {
    let dataSource = ActorDS()
    
    //MARK: - Network Request

    func getPersonDetail(id: Int) {
        
        Networking.request(router: PeopleRouter.detail(id), shouldShowLoading: true) { (response: ActorResponseModel?, errorString) in
            guard let response = response else { return }
            
            self.dataSource.biography = response.biography
            self.dataSource.name = response.name
            self.emit(.getDetailSuccess)
            
        } onFailure: { (errorString, errorType) in
            guard let error = errorString else { return }
            
            self.emit(.networkFailure(error))
        }
    }
    
    func getActedMovies(id: Int) {
        
        Networking.request(router: PeopleRouter.actedMovies(id)) { (response: ActedMoviesResponseModel?, errorString) in
            guard let cast = response?.cast else { return }
            
            self.dataSource.actedMovies = Array(cast.prefix(10))
            self.dataSource.allActedMovies = cast
            self.emit(.getActedMoviesSuccess)
            
        } onFailure: { (errorString, errorType) in
            guard let error = errorString else { return }
            
            self.emit(.networkFailure(error))
        }
    }
    
    func getActorImages(id: Int) {
        
        Networking.request(router: PeopleRouter.images(id)) { (response: PersonImageResponseModel?, errorString) in
            guard let profiles = response?.profiles else { return }
            
            self.dataSource.photos = profiles
            self.emit(.getImagesSuccess)
            
        } onFailure: { (errorString, errorType) in
            guard let error = errorString else { return }
            
            self.emit(.networkFailure(error))
        }
    }
}
