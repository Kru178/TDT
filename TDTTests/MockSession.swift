//
//  MockSession.swift
//  TDTTests
//
//  Created by Sergei Krupenikov on 18.04.2021.
//

import Foundation
@testable import TDT

class MockSession {
    
    let result: Result<Data, TDError>
    init(result: Result<Data, TDError>) {
        self.result = result
    }
    
}

extension MockSession : NetworkControllerDelegate {
    func get(resourceType: String, completed: @escaping (Result<Data, TDError>) -> Void) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            completed(self.result)
        }
    }
}
