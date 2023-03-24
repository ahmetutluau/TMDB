//
//  TrailersResponseModel.swift
//  NetflixClone
//
//  Created by Ahmet Utlu on 13.03.2023.
//

import Foundation

struct TrailersResponseModel: Codable {
    let id: Int
    let results: [TrailerModel]?
}

// MARK: - Result
struct TrailerModel: Codable {
    let name, key: String?
    let publishedAt, id: String?

    enum CodingKeys: String, CodingKey {
        case name, key
        case publishedAt = "published_at"
        case id
    }
}
