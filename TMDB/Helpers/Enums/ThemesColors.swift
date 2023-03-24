//
//  ThemesColors.swift
//  NetflixClone
//
//  Created by Ahmet Utlu on 22.03.2023.
//

import UIKit

enum ThemeColors: CaseIterable {
    case background, background2, background3, buttoncolor, buttoncolor2, buttoncolor3, splashBacground
    
    var color: UIColor {
        switch self {
        case .background:
            return UIColor.withHex("060F19")
        case .background2:
            return UIColor.withHex("0D243F")
        case .background3:
            return UIColor.withHex("07101B")
        case .buttoncolor:
            return UIColor.withHex("53B3D8")
        case .buttoncolor2:
            return UIColor.withHex("95CDA6")
        case .buttoncolor3:
            return UIColor.withHex("7EC4B5")
        case .splashBacground:
            return UIColor.withHex("0D253F")
        }
    }
}
