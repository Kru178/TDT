//
//  Date+Ext.swift
//  TDT
//
//  Created by Sergei Krupenikov on 03.04.2021.
//

import Foundation

extension Date {
    
    func convertToStringFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        
        dateFormatter.dateStyle = .long
        return dateFormatter.string(from: self)
    }
}
