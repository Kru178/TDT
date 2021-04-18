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
        
        let validJSONData = TestData.validJSONString.rawValue.data(using: .utf8)
        let networkController = NetworkController()
        let mockSession = MockSession(result: .success(validJSONData!))
        networkController.getMovies(anObject: mockSession, for: 1) { result in
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
    
    func testFailureMovieFetch() throws {
        
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
    
    func testFailureWithEmptyDataMovieFetch() throws {
        
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
    
    func testFailureWithCorruptJSONMovieFetch() throws {
        
        // Allows us to continue to the end of the function.
        let expectation = self.expectation(description: "Waiting for planets")
        
        let invalidJSONData = TestData.invalidJSONString.rawValue.data(using: .utf8)
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
