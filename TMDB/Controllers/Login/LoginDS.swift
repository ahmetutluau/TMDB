//
//  LoginDS.swift
//  NetflixClone
//
//  Created by Ahmet Utlu on 21.03.2023.
//

import Foundation

enum LoginDSStateChange: StateChange {
    
}

class LoginDS: StatefulDS<LoginDSStateChange> {
    var success = false
    var expiresAt: String?
    var username: String?
    var password: String?
    var account: AccountDetailResponseModel?
}
