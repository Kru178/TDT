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
    @IBOutlet weak var view: UIView!
    
    let cView = customView()
    let progressView = ProgressView()
    
    func downloadImage(fromURL url: String) {
        let urlString = "https://image.tmdb.org/t/p/original/" + url
        NetworkManager.shared.downloadImage(from: urlString) { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async { self.imageView.image = image }
        }
    }
    
    
    
    func configure() {
        view.addSubview(progressView)
        view.addSubview(cView)
        
        
        progressView.translatesAutoresizingMaskIntoConstraints = false
        releaseDateLabel.translatesAutoresizingMaskIntoConstraints = false
        cView.translatesAutoresizingMaskIntoConstraints = false
        progressView.frame = self.frame
        NSLayoutConstraint.activate([
            progressView.leadingAnchor.constraint(equalTo: view.trailingAnchor),
            progressView.topAnchor.constraint(equalTo: view.topAnchor),
            progressView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            progressView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
//        progressView.
        cView.draw(self.frame, start: CGPoint(x: imageView.frame.size.width, y: self.frame.height - 30), end: CGPoint(x: self.frame.width, y: self.frame.height - 30))
    }
    
}

class customView: UIView {
    
    func draw(_ rect: CGRect, start: CGPoint, end: CGPoint) {
        
        let aPath = UIBezierPath()
        
//        let startPoint = CGPoint(x: imageView.frame.size.width, y: self.frame.height - 30)
//        let endPoint = CGPoint(x: self.frame.width, y: self.frame.height - 30)
        
        let startPoint = start
        let endPoint = end

        aPath.move(to: startPoint)
        aPath.addLine(to: endPoint)

        UIColor.lightGray.set()
        aPath.lineWidth = 1.0
        aPath.stroke()
    }
}
