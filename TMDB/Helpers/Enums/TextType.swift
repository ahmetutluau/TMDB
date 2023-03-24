//
//  TextType.swift
//  NetflixClone
//
//  Created by Ahmet Utlu on 2.03.2023.
//

import Foundation

enum TextType {
    /// String.
    case plain(String)
    /// NSAttributedString.
    case attributed(NSAttributedString)
    /// Empty string.
    case empty
}
