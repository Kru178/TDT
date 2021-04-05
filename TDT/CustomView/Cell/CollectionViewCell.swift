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
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var progressSubView: UIView!
    var onReuse: () -> Void = {}
    
    let progressView = ProgressView()
    
    
    override func layoutSubviews() {
        
        self.contentView.layer.cornerRadius = 5.0
        self.contentView.clipsToBounds = true
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 3.0
        layer.shadowOpacity = 0.7
        layer.cornerRadius = 5.0
        layer.masksToBounds = false
        
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
        imageView.image = nil
        imageView.cancelImageLoad()
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
            return layoutAttributes
        }

    @IBAction func scheduleButtonPressed(_ sender: UIButton) {
       
    }
   
    func setup(with movie: Results) {
        
        
        titleLabel.text = movie.title
        descriptionLabel.text = movie.overview
        releaseDateLabel.text = movie.releaseDate!.convertToDateFormat().convertToStringFormat()
        progressView.shapeLayer.strokeEnd = CGFloat(movie.voteAverage / 10.0)
        ratingLabel.text = "\(Int(movie.voteAverage * 10.0))"
        
        let url = URL(string: "https://image.tmdb.org/t/p/original/" + movie.posterPath)
        imageView.loadImage(at: url!)

    }

}
