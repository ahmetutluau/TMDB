//
//  PersonImageResponseModel.swift
//  NetflixClone
//
//  Created by Ahmet Utlu on 15.03.2023.
//

import Foundation

struct PersonImageResponseModel: Codable {
    let id: Int
    let profiles: [Profile]?
}

// MARK: - Profile
struct Profile: Codable {
    let aspectRatio: Double?
    let height: Int?
    let filePath: String?
    let voteAverage: Double?
    let voteCount, width: Int?

    enum CodingKeys: String, CodingKey {
        case aspectRatio = "aspect_ratio"
        case height
        case filePath = "file_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case width
    }
}
