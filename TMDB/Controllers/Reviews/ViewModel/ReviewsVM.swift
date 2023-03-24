//
//  ReviewsVM.swift
//  NetflixClone
//
//  Created by Ahmet Utlu on 13.03.2023.
//

import Foundation

enum ReviewsVMStateChange: StateChange {
    case getReviewsSuccess
    case networkFailure(String)
}

class ReviewsVM: StatefulVM<ReviewsVMStateChange> {
    let dataSource = ReviewsDS()
    var page = 1
    
    //MARK: - Network Request

    func getMovieReviews(id: Int) {
        let model = ReviewsRequestModel(page: page, id: id)
        
        Networking.request(router: MovieRouter.reviews(model), shouldShowLoading: true) { (response: ReviewsResponseModel?, errorString) in
            guard let response = response,
                  let results = response.results else { return }
            
            self.dataSource.reviews.append(contentsOf: results)
            self.page += 1
            self.emit(.getReviewsSuccess)
            
        } onFailure: { (errorString, errorType) in
            guard let error = errorString else { return }
            
            self.emit(.networkFailure(error))
        }
    }
}
