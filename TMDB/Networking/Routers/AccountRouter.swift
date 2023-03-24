//
//  AccountRouter.swift
//  NetflixClone
//
//  Created by Ahmet Utlu on 23.03.2023.
//

import Foundation
import Alamofire

enum AccountRouter: EndpointConfiguration {
    
    case detail(String)
    
    var method: HTTPMethod {
        switch self {
        case .detail:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .detail:
            return "/account"
        }
    }
    
    var queryParameters: QueryStringParameters {
        switch self {
        case .detail(let sessionId):
            return ["api_key": "d01c48435a43627d2ac87bf0d9e756ee",
                    "session_id": sessionId]
        }
    }
    var httpBody: Data? {
        switch self {
        case .detail:
            return nil
        }
    }
    
    var headers: [CustomHTTPHeader]? {
        return nil
    }
    
    
}
