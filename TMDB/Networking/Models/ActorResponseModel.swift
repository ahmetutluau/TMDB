//
//  ActorResponseModel.swift
//  NetflixClone
//
//  Created by Ahmet Utlu on 14.03.2023.
//

import Foundation

struct ActorResponseModel: Codable {
    let adult: Bool?
    let biography, birthday, deathday: String?
    let gender: Int?
    let homepage: String?
    let id: Int
    let imdbID, knownForDepartment, name, placeOfBirth: String?
    let popularity: Double?
    let profilePath: String?

    enum CodingKeys: String, CodingKey {
        case adult
        case biography, birthday, deathday, gender, homepage, id
        case imdbID = "imdb_id"
        case knownForDepartment = "known_for_department"
        case name
        case placeOfBirth = "place_of_birth"
        case popularity
        case profilePath = "profile_path"
    }
}
