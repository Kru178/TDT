//
//  TestData.swift
//  TDTTests
//
//  Created by Sergei Krupenikov on 18.04.2021.
//

import Foundation
@testable import TDT

enum TestData : String {
    case validJSONString = """
        {
        "page": 1,
        "results": [
        {
        "adult": false,
        "backdrop_path": "/h9DIlghaiTxbQbt1FIwKNbQvEL.jpg",
        "genre_ids": [
        28,
        12,
        53
        ],
        "id": 581387,
        "original_language": "ko",
        "original_title": "백두산",
        "overview": "A group of unlikely heroes from across the Korean peninsula try to save the day after a volcano erupts on the mythical and majestic Baekdu Mountain.",
        "popularity": 669.563,
        "poster_path": "/zoeKREZ2IdAUnXISYCS0E6H5BVh.jpg",
        "release_date": "2019-12-19",
        "title": "Ashfall",
        "video": false,
        "vote_average": 6.5,
        "vote_count": 231
        }
        ]
        }
        """
    
    case invalidJSONString = """
        {
        "page": 1,
        "results": [
        {
        "adult": false,
        "backdrop_path": "/h9DIlghaiTxbQbt1FIwKNbQvEL.jpg",
        "genre_ids": [
        28,
        12,
        53
        ],
        "id": 581387,
        "original_language": "ko",
        "original_title": "백두산",
        "overview": "A group of unlikely heroes from across the Korean peninsula try to save the day after a volcano erupts on the mythical and majestic Baekdu Mountain.",
        "popularity": 669.563,
        "poster_path": "/zoeKREZ2IdAUnXISYCS0E6H5BVh.jpg",
        "release_date": "2019-12-19",
        "title": "Ashfall",
        "video": false,
        "vote_average": 6.5,
        "vote_count": 231
        }
        ]

        """
}
