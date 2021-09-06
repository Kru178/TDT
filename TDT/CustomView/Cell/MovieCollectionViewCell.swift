//
//  CollectionViewCell.swift
//  TDT
//
//  Created by Sergei Krupenikov on 30.03.2021.
//

import UIKit

protocol MovieCollectionViewCellDelegate: AnyObject {
    func collectionViewCell(_ collectionViewCell: MovieCollectionViewCell, didSelectMovie movie: Movie)
}

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var progressSubView: UIView!
    
    static let reuseIdentifier = "CollectionViewCell"
    private var movie: Movie?
    let progressView = ProgressView()
    weak var delegate: MovieCollectionViewCellDelegate?
  
    override func layoutSubviews() {
        super.layoutSubviews()
        configure()
    }
    
    func configure() {
        contentView.layer.cornerRadius = 5.0
        contentView.clipsToBounds = true
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 3.0
        layer.shadowOpacity = 0.7
        layer.cornerRadius = 5.0
        layer.masksToBounds = false
        
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
        imageView.image = nil
        titleLabel.text = nil
        releaseDateLabel.text = nil
        descriptionLabel.text = nil
        ratingLabel.text = nil
        
        imageView.cancelImageLoad()
    }
    
    func setup(with movie: Movie) {
        self.movie = movie
        
        titleLabel.text = movie.title
        descriptionLabel.text = movie.overview
        releaseDateLabel.text = movie.releaseDate.convertToDateFormat().convertToStringFormat()
        
        let vote = movie.voteAverage
        progressView.shapeLayer.strokeEnd = CGFloat(vote / 10.0)
        ratingLabel.text = "\(Int(vote * 10.0))"
        
        guard let path = movie.posterPath else {return}
        guard let url = URL(string: "https://image.tmdb.org/t/p/original/" + path) else {
            return
        }
        imageView.loadImage(at: url, cropped: true)
    }

    @IBAction func schedule(_ sender: UIButton) {
        guard let movie = movie else {
            return
        }
        delegate?.collectionViewCell(self, didSelectMovie: movie)
    }

}
