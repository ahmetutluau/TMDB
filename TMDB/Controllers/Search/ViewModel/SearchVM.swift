//
//  SearchVM.swift
//  NetflixClone
//
//  Created by Ahmet Utlu on 5.03.2023.
//

import UIKit

enum SearchVMStateChange: StateChange {
    case searchMoviesSuccess
    case networkFailure(String)
}

class SearchVM: StatefulVM<SearchVMStateChange> {

    let dataSource = SearchDS()
    
    //MARK: - Network Request

    func searchMovies(text: String) {
        Networking.request(router: MovieRouter.search(text), shouldShowLoading: true) { (response: MoviesResponseModel?, errorString) in
            
            guard let results = response?.results else { return }
            
            self.dataSource.searchedMovies = results
            self.emit(.searchMoviesSuccess)
            
        } onFailure: { (errorString, errorType) in
            guard let error = errorString else { return }
            
            self.emit(.networkFailure(error))
        }
    }
}
