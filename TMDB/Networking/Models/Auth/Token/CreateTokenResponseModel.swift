//
//  CreateTokenResponseModel.swift
//  NetflixClone
//
//  Created by Ahmet Utlu on 21.03.2023.
//

import Foundation

struct CreateTokenResponseModel: Codable {
    var success: Bool
    var expiresAt: String?
    var requestToken: String?
    
    enum CodingKeys: String, CodingKey {
        case success
        case expiresAt = "expires_at"
        case requestToken = "request_token"
    }
}
