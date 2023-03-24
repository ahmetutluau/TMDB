//
//  AuthRouter.swift
//  NetflixClone
//
//  Created by Ahmet Utlu on 21.03.2023.
//

import Foundation
import Alamofire

enum AuthRouter: EndpointConfiguration {
    
    case createToken
    case login(LoginRequestModel)
    case createSession(String)
    case logout(String)
    
    var method: HTTPMethod {
        switch self {
        case .createToken:
            return .get
        case .login:
            return .post
        case .createSession:
            return .post
        case .logout:
            return .delete
        }
    }
    
    var path: String {
        switch self {
        case .createToken:
            return "/authentication/token/new"
        case .login:
            return "/authentication/token/validate_with_login"
        case .createSession:
            return "/authentication/session/new"
        case .logout:
            return "/authentication/session"
        }
    }
    
    var queryParameters: QueryStringParameters {
        switch self {
        case .createToken, .login, .createSession, .logout:
            return ["api_key": "d01c48435a43627d2ac87bf0d9e756ee"]
        }
    }
    var httpBody: Data? {
        switch self {
        case .createToken:
            return nil
        case .login(let model):
            return model.asData
        case .createSession(let token):
            return ["request_token": token].asData
        case .logout(let sessionId):
            return ["session_id": sessionId].asData
        }
    }
    
    var headers: [CustomHTTPHeader]? {
        return [.contentType]
    }
    
}
