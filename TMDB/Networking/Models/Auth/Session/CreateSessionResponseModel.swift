//
//  CreateSessionResponseModel.swift
//  NetflixClone
//
//  Created by Ahmet Utlu on 22.03.2023.
//

import Foundation

struct CreateSessionResponseModel: Codable {
    var success: Bool
    var sessionId: String?
    
    enum CodingKeys: String, CodingKey {
        case success
        case sessionId = "session_id"
    }
}
