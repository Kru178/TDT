//
//  Movie.swift
//  TDT
//
//  Created by Sergei Krupenikov on 30.03.2021.
//

import Foundation

struct MovieList: Codable {
    let page: Int
    let totalPages: Int?
    let results: [Movie]
}

struct Movie: Codable {
    let posterPath: String?
    let id: Int
    let title: String
    let voteAverage: Double
    let overview: String?
    let releaseDate: String
    let backdropPath: String?
    let tagline: String?
}

