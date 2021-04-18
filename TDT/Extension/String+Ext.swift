//
//  String+Ext.swift
//  TDT
//
//  Created by Sergei Krupenikov on 03.04.2021.
//

import Foundation

extension String {
    
    func convertToDateFormat() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let output = dateFormatter.date(from: self) {
            return output
        } else {
//            failure?
            return Date()
        }
    }
}
