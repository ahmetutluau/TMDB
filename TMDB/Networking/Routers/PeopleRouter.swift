//
//  PeopleRouter.swift
//  NetflixClone
//
//  Created by Ahmet Utlu on 14.03.2023.
//

import Foundation
import Alamofire

enum PeopleRouter: EndpointConfiguration {
    
    case detail(Int)
    case actedMovies(Int)
    case images(Int)
    
    var method: HTTPMethod {
        switch self {
        case .detail, .actedMovies, .images:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .detail(let id):
            return "/person/\(id)"
        case .actedMovies(let id):
            return "/person/\(id)/movie_credits"
        case .images(let id):
            return "/person/\(id)/images"
        }
    }
    
    var queryParameters: QueryStringParameters {
        switch self {
        case .detail, .actedMovies, .images:
            return ["api_key": "d01c48435a43627d2ac87bf0d9e756ee"]
        }
    }
    var httpBody: Data? {
        return nil
    }
    
    var headers: [CustomHTTPHeader]? {
        return nil
    }
    
}
