//
//  CreditsResponseModel.swift
//  NetflixClone
//
//  Created by Ahmet Utlu on 10.03.2023.
//

import Foundation

struct CreditsResponseModel: Codable {
    let id: Int
    let cast: [Cast]?
}

// MARK: - Cast
struct Cast: Codable {
    let adult: Bool?
    let id: Int
    let gender: Int?
    let name, originalName: String?
    let popularity: Double?
    let profilePath: String?
    let castID: Int?
    let character: String?
    let creditID: String?
    let order: Int?
    let job: String?

    enum CodingKeys: String, CodingKey {
        case adult, gender, id
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case castID = "cast_id"
        case character
        case creditID = "credit_id"
        case order, job
    }
}
