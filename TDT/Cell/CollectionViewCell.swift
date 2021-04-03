//
//  CollectionViewCell.swift
//  TDT
//
//  Created by Sergei Krupenikov on 30.03.2021.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var ratingProgressBar: UIProgressView!
    
    func downloadImage(fromURL url: String) {
        let urlString = "https://image.tmdb.org/t/p/original/" + url
        NetworkManager.shared.downloadImage(from: urlString) { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async { self.imageView.image = image }
        }
    }
    
    override func draw(_ rect: CGRect) {
        
        let aPath = UIBezierPath()
        
        let startPoint = CGPoint(x: imageView.frame.size.width, y: self.frame.height - 30)
        let endPoint = CGPoint(x: self.frame.width, y: self.frame.height - 30)

        aPath.move(to: startPoint)
        aPath.addLine(to: endPoint)

        UIColor.lightGray.set()
        aPath.lineWidth = 1.0
        aPath.stroke()
    }
    
    func configure() {
    }
    
}
