//
//  ImageLoader.swift
//  TDT
//
//  Created by Sergei Krupenikov on 04.04.2021.
//

import UIKit

class ImageLoader {
    static let shared = ImageLoader()
    
  private var loadedImages = [URL: UIImage]()
  private var runningRequests = [UUID: URLSessionDataTask]()
    
    func loadImage(_ url: URL, _ completion: @escaping (Result<UIImage, Error>) -> Void) -> UUID? {

      // 1
      if let image = loadedImages[url] {
        completion(.success(image))
        return nil
      }

      // 2
      let uuid = UUID()

      let task = URLSession.shared.dataTask(with: url) { data, response, error in
        // 3
        defer {self.runningRequests.removeValue(forKey: uuid) }

        // 4
        if let data = data, let image = UIImage(data: data) {
//            print("image size: \(image.size)")
          let resizedImage = self.resizedImageWith(image: image)
          self.loadedImages[url] = resizedImage
          completion(.success(resizedImage))
          return
        }

        // 5
        guard let error = error else {
          // without an image or an error, we'll just ignore this for now
          // you could add your own special error cases for this scenario
          return
        }

        guard (error as NSError).code == NSURLErrorCancelled else {
          completion(.failure(error))
          return
        }

        // the request was cancelled, no need to call the callback
      }
      task.resume()

      // 6
      runningRequests[uuid] = task
      return uuid
    }
    
    func cancelLoad(_ uuid: UUID) {
      runningRequests[uuid]?.cancel()
      runningRequests.removeValue(forKey: uuid)
    }
    
    func resizedImageWith(image: UIImage) -> UIImage {

        let targetSize = CGSize(width: 150, height: 210)
        let imageSize = image.size
        let newWidth  = targetSize.width  / image.size.width
        let newHeight = targetSize.height / image.size.height
        var newSize: CGSize

        if(newWidth > newHeight) {
            newSize = CGSize(width: imageSize.width * newHeight, height: imageSize.height * newHeight)
        } else {
            newSize = CGSize(width: imageSize.width * newWidth,  height: imageSize.height * newWidth)
        }

        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)

        image.draw(in: rect)

        guard let newImage = UIGraphicsGetImageFromCurrentImageContext() else {return image}
        UIGraphicsEndImageContext()

        return newImage
    }
    
    func empty() {
        loadedImages.removeAll()
    }
}
