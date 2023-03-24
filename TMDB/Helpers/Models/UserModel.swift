//
//  UserModel.swift
//  NetflixClone
//
//  Created by Ahmet Utlu on 22.03.2023.
//

import Foundation

struct UserModel: Codable {
    var username: String?
    var name: String?
    var avatar: String?
    
    mutating func setup(username: String?, name: String?) {
        self.username = username
        self.name = name
    }
    
    mutating func setup(model: AccountDetailResponseModel) {
        self.username = model.username
        self.name = model.name
        self.avatar = model.avatar?.tmdb?.avatarPath
    }
}
