//
//  Image+Ext.swift
//  TDT
//
//  Created by Sergei Krupenikov on 05.04.2021.
//

import UIKit

extension UIImageView {
    
  func loadImage(at url: URL) {
    UIImageLoader.loader.load(url, for: self)
  }

    
  func cancelImageLoad() {
    UIImageLoader.loader.cancel(for: self)
  }
}
