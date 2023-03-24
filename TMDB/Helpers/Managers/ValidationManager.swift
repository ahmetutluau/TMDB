//
//  ValidationManager.swift
//  NetflixClone
//
//  Created by Ahmet Utlu on 21.03.2023.
//

import Foundation

class ValidationManager {
    static let shared = ValidationManager()
    private init() {}
    
    func validate(email: String?) -> Bool {
        guard let email = email else { return false }
        return email.isValidEmail()

    }
}
