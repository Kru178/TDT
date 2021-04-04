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
    
    @IBOutlet weak var progressSubView: UIView!
    var onReuse: () -> Void = {}
    
    let progressView = ProgressView()
    
//    func downloadImage(fromURL url: String) {
//        let urlString = "https://image.tmdb.org/t/p/original/" + url
//        NetworkManager.shared.downloadImage(from: urlString) { [weak self] image in
//            guard let self = self else { return }
//            DispatchQueue.main.async { self.imageView.image = image }
//        }
//    }
    
    override func layoutSubviews() {
        
        self.contentView.layer.cornerRadius = 5.0
        self.contentView.clipsToBounds = true
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 3.0
        layer.shadowOpacity = 0.7
        layer.cornerRadius = 5.0
        layer.masksToBounds = false
        draw(self.frame)
        configure()
    }
    
    
    func configure() {
        progressSubView.addSubview(progressView)
        progressSubView.bringSubviewToFront(ratingLabel)
        progressSubView.translatesAutoresizingMaskIntoConstraints = false
        progressView.translatesAutoresizingMaskIntoConstraints = false
        releaseDateLabel.translatesAutoresizingMaskIntoConstraints = false
        progressView.frame = progressSubView.frame
        NSLayoutConstraint.activate([
            progressView.centerXAnchor.constraint(equalTo: progressSubView.centerXAnchor),
            progressView.centerYAnchor.constraint(equalTo: progressSubView.centerYAnchor)
        ])
    }

    
    override func prepareForReuse() {
        super.prepareForReuse()
        onReuse()
        self.imageView.image = nil
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
            return layoutAttributes
        }
}
