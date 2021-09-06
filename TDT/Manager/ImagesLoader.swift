//
//  ImageLoader.swift
//  TDT
//
//  Created by Sergei Krupenikov on 04.04.2021.
//

import UIKit

class ImagesLoader {
    static let shared = ImagesLoader()
    
    private var loadedImages = [URL: UIImage]()
    private var runningRequests = [UUID: URLSessionDataTask]()
    
    func loadImage(_ url: URL, resize: Bool, _ completion: @escaping (Result<UIImage, Error>) -> Void) -> UUID? {
        if let image = loadedImages[url] {
            completion(.success(image))
            return nil
        }
        let uuid = UUID()
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            defer {
                self.runningRequests.removeValue(forKey: uuid)
            }
            if let data = data, let image = UIImage(data: data) {
                var imageToShow = UIImage()
                if resize {
                    let resizedImage = self.resizedImageWith(image: image)
                    self.loadedImages[url] = resizedImage
                    imageToShow = resizedImage
                } else {
                    self.loadedImages[url] = image
                    imageToShow = image
                }
                completion(.success(imageToShow))
                return
            }
            guard let error = error else {
                return
            }
            guard (error as NSError).code == NSURLErrorCancelled else {
                completion(.failure(error))
                return
            }
        }
        task.resume()
        
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
}
