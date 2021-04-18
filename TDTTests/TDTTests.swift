//
//  TDTTests.swift
//  TDTTests
//
//  Created by Sergei Krupenikov on 15.04.2021.
//

import XCTest
@testable import TDT

class TDTTests: XCTestCase {
    
    func testDateToString() {
        let stringDate = "1999-10-15"
        let date = stringDate.convertToDateFormat()
        let string = date.convertToStringFormat()
        XCTAssertEqual(string, "October 15, 1999")
    }
    
    func testSuccessfulMovieFetch() throws {
        
        let expectation = self.expectation(description: "Waiting for movies")
        
        let networkController = NetworkController()
        networkController.getMovies(anObject: URLSession.shared, for: 1) { result in
            switch result {
            
            case .failure:
                XCTAssert(false)
                
            case .success(let list):
                XCTAssert(!list.results.isEmpty)
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5) { possibleError in
            print("Finished waiting: \(String(describing: possibleError))")
        }   
    }
    
    func testFailurePlanetFetch() throws {
        
        let expectation = self.expectation(description: "Waiting for movies")
        
        let networkController = NetworkController()
        let mockSession = MockSession(result: .failure(.invalidData))
        networkController.getMovies(anObject: mockSession, for: 1) { (result) in
            switch result {
            
            case .failure(let error):
                print("All is going according to plan: \(error)")
                
            case .success:
                XCTFail()
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5) { possibleError in
            print("Finished waiting: \(String(describing: possibleError))")
        }
        
    }
    
    func testFailureWithEmptyDataPlanetFetch() throws {
        
        // Allows us to continue to the end of the function.
        let expectation = self.expectation(description: "Waiting for movies")
        
        let networkController = NetworkController()
        let mockSession = MockSession(result: .success(Data()))
        networkController.getMovies(anObject: mockSession,for: 1) { (result) in
            switch result {
            
            case .failure(let error):
                print("All is going according to plan: \(error)")
                
            case .success:
                XCTFail()
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5) { possibleError in
            print("Finished waiting: \(String(describing: possibleError))")
        }
    }
    
    func testFailureWithCorruptJSONPlanetFetch() throws {
        
        // Allows us to continue to the end of the function.
        let expectation = self.expectation(description: "Waiting for planets")
        
        let invalidJSONString = """
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
        
        let invalidJSONData = invalidJSONString.data(using: .utf8)
        
        let networkController = NetworkController()
        let mockSession = MockSession(result: .success(invalidJSONData!))
        networkController.getMovies(anObject: mockSession, for: 1) { (result) in
            switch result {
            
            case .failure(let error):
                print("All is going according to plan: \(error)")
                
            case .success:
                XCTFail()
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5) { possibleError in
            print("Finished waiting: \(String(describing: possibleError))")
        }
        
    }
}
