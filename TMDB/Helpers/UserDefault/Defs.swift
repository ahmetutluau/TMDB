//
//  Defs.swift
//  NetflixClone
//
//  Created by Ahmet Utlu on 22.03.2023.
//

import Foundation

class Defs {
    
    static let shared = Defs()
    private init() {}
    
    var defsUserModel: UserModel? {
        get {
            return UserDefaultsManager.get(forKey: "userModel")
        }
        set(defsModel) {
            UserDefaultsManager.set(defsModel, forKey: "userModel")
        }
    }
}
