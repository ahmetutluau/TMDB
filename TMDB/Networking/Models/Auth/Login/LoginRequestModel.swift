//
//  LoginRequestModel.swift
//  NetflixClone
//
//  Created by Ahmet Utlu on 21.03.2023.
//

import Foundation

struct LoginRequestModel: Codable {
    var username: String?
    var password: String?
    var requestToken: String?
    
    enum CodingKeys: String, CodingKey {
        case username, password
        case requestToken = "request_token"
    }
}
