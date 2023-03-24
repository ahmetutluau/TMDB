//
//  NetworkError.swift
//  NetflixClone
//
//  Created by Ahmet Utlu on 1.03.2023.
//

import Foundation

enum NetworkError {
    case noError
    case credentialsWrong
    case notConnectedInternet
    case serviceResponseFailed
    case conflictCredentials
    case emptyOrNil
    case authenticationLocked
    case notValidOtpCode
    case redirectAuth
}
