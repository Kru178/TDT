//
//  UIViewController+Ext.swift
//  TDT
//
//  Created by Sergei Krupenikov on 18.04.2021.
//

import UIKit

extension UIViewController {
    
    func showAlertOnMainThread(for movie: Movie, date: Date) {
        let stringDate = date.convertToDateAndTime()
        DispatchQueue.main.async {
            let ac = UIAlertController(title: "Scheduled!",
                                       message: "We will remind you to watch the \(movie.title) movie on \(stringDate)",
                                       preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default)
            ac.addAction(action)
            self.present(ac, animated: true)
        }
    }
}
