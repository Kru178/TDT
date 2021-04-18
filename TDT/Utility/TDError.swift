//
//  TDError.swift
//  TDT
//
//  Created by Sergei Krupenikov on 30.03.2021.
//

import Foundation

enum TDError: String, Error {
    
    case invalidURL = "This URL created an invalid request. Please try again."
    case unableToComplete = "Unable to complete your request. Please check your internet connection."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid."
}
