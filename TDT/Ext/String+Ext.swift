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
        dateFormatter.dateFormat = "YYYY-MM-DD"
        let dateStyle = dateFormatter.dateStyle
        
        return dateFormatter.date(from: self)!
    }
}
