//
//  Image+Ext.swift
//  TDT
//
//  Created by Sergei Krupenikov on 05.04.2021.
//

import UIKit

extension UIImageView {
    
    func loadImage(at url: URL, cropped: Bool) {
    UIImageLoader.loader.load(url, resize: cropped, for: self)
  }

  func cancelImageLoad() {
    UIImageLoader.loader.cancel(for: self)
  }
}
