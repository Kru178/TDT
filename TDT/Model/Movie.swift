//
//  Movie.swift
//  TDT
//
//  Created by Sergei Krupenikov on 30.03.2021.
//

import Foundation

struct MovieList: Codable {
    let page: Int
//    let totalResults: Int?
//    let totalPages: Int?
    let results: [Results]

}


struct Results: Codable {
//    let popularity: Double?
//    let voteCount: Int?
//    let video: Bool?
    let posterPath: String
    let id: Int
//    let adult: Bool?
//    let backdropPath: String?
//    let originalTitle: String?
//    let genreIDS: [Int]?
    let title: String
    let voteAverage: Double
    let overview: String
    let releaseDate: String?

    
}

