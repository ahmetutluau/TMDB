//
//  AccountDetailResponseModel.swift
//  NetflixClone
//
//  Created by Ahmet Utlu on 23.03.2023.
//

import Foundation

struct AccountDetailResponseModel: Codable {
    let avatar: Avatar?
    let id: Int?
    let name, username: String?
}

// MARK: - Avatar
struct Avatar: Codable {
    let gravatar: Gravatar?
    let tmdb: Tmdb?
}

// MARK: - Gravatar
struct Gravatar: Codable {
    let hash: String?
}

// MARK: - Tmdb
struct Tmdb: Codable {
    let avatarPath: String?

    enum CodingKeys: String, CodingKey {
        case avatarPath = "avatar_path"
    }
}
