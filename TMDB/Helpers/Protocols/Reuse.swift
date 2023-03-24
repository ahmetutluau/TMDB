//
//  Reuse.swift
//  NetflixClone
//
//  Created by Ahmet Utlu on 1.03.2023.
//

import Foundation

protocol Reuse: AnyObject {
    
    /// Reuse identifier
    static var reuseIdentifier: String { get }
}
