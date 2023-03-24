//
//  DetailSections.swift
//  NetflixClone
//
//  Created by Ahmet Utlu on 8.03.2023.
//

import Foundation

enum DetailSections: String, CaseIterable {
    case title
    case overview = "Overview"
    case trailers = "Trailers"
    case topCast = "Top Billed Cast"
    case similarMovies = "Similar movies"
    case readReviews = ""
}
