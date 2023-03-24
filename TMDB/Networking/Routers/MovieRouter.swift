//
//  MovieRouter.swift
//  NetflixClone
//
//  Created by Ahmet Utlu on 1.03.2023.
//

import Foundation
import Alamofire

enum MovieRouter: EndpointConfiguration {
    
    case popular(Int)
    case detail(Int)
    case topRated(Int)
    case nowPlaying
    case upComing(Int)
    case search(String)
    case similar(Int)
    case credits(Int)
    case videos(Int)
    case reviews(ReviewsRequestModel)
    
    var method: HTTPMethod {
        switch self {
        case .popular, .detail, .topRated, .nowPlaying, .upComing, .search, .similar, .credits, .videos, .reviews :
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .popular:
            return "/movie/popular"
        case .detail(let id):
            return "/movie/\(id)"
        case .topRated:
            return "/movie/top_rated"
        case .nowPlaying:
            return "/movie/now_playing"
        case .upComing:
            return "/movie/upcoming"
        case .search:
            return "/search/movie"
        case .similar(let id):
            return "/movie/\(id)/similar"
        case .credits(let id):
            return "/movie/\(id)/credits"
        case .videos(let id):
            return "/movie/\(id)/videos"
        case .reviews(let model):
            return  "/movie/\(model.id)/reviews"
        }
    }
    
    var queryParameters: QueryStringParameters {
        switch self {
        case .popular(let page) :
            return ["api_key": "d01c48435a43627d2ac87bf0d9e756ee",
                    "page": "\(page)"]
        case .topRated(let page):
            return ["api_key": "d01c48435a43627d2ac87bf0d9e756ee",
                    "page": "\(page)"]
        case .upComing(let page):
            return ["api_key": "d01c48435a43627d2ac87bf0d9e756ee",
                    "page": "\(page)"]
        case .reviews(let model):
            return ["api_key": "d01c48435a43627d2ac87bf0d9e756ee",
                    "page": "\(model.page)"]
        case .detail, .nowPlaying, .similar, .credits, .videos:
            return ["api_key": "d01c48435a43627d2ac87bf0d9e756ee"]
        case .search(let text):
            return ["api_key": "d01c48435a43627d2ac87bf0d9e756ee",
                    "query": "\(text)"]
        }
    }
    var httpBody: Data? {
        return nil
    }
    
    var headers: [CustomHTTPHeader]? {
        return nil
    }
    
}
