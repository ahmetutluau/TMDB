//
//  ActedMoviesResponseModel.swift
//  NetflixClone
//
//  Created by Ahmet Utlu on 14.03.2023.
//

import Foundation

struct ActedMoviesResponseModel: Codable {
    let cast: [ActedMoviesModel]?
    let id: Int
}

// MARK: - Cast
struct ActedMoviesModel: Codable {
    let adult: Bool?
    let backdropPath: String?
    let id: Int
    let originalTitle, overview: String?
    let popularity: Double?
    let posterPath: String?
    let releaseDate, title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
    let character: String?
    let creditID: String?
    let order: Int?
    let department, job: String?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case id
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case character
        case creditID = "credit_id"
        case order, department, job
    }
}
