//
//  CollectionViewController.swift
//  TDT
//
//  Created by Sergei Krupenikov on 30.03.2021.
//

import UIKit

private let reuseIdentifier = "cell"

class CollectionViewController: UICollectionViewController {
    
    private let sectionInsets = UIEdgeInsets(
        top: 10.0,
        left: 20.0,
        bottom: 10.0,
        right: 20.0)
    
    private let itemsPerRow: CGFloat = 1
    
    var list: [Results] = []
    var list2019: [Results] = []
    var page = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.alwaysBounceVertical = true
        
        title = "Top 2019 Movies"
      
        updateUI(for: page)
        
    }
    
    func updateUI(for page: Int) {
        
        NetworkManager.shared.getMovies(for: page) { [weak self] (result) in
            guard let self = self else {return}
            
            switch result {
            
            case .success(let movies):
                self.list = movies.results
                for movie in self.list {
                    let date = movie.releaseDate?.convertToDateFormat()
                    let components = Calendar.current.dateComponents([.year, .month, .day], from: date!)
                    if components.year == 2019 {
                        
                        self.list2019.append(movie)
                        
                    }
                }
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    for movie in self.list2019 {
                        print("movie: \(movie.title), release date: \(movie.releaseDate!)")
                    }
                }
                
            case .failure(let error):
                print("nil")
                print(error.localizedDescription)
            }
        }
        
        
        
        
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list2019.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.layer.shadowRadius = 2
        cell.layer.shadowOpacity = 0.5
        cell.layer.masksToBounds = false
        cell.draw(cell.contentView.frame)
 
        if list2019.isEmpty {
            cell.titleLabel.text = "title"
        } else {
            cell.titleLabel.text = list2019[indexPath.item].title
            //            cell.ratingLabel.text = "Rating: \(list2019[indexPath.item].voteAverage)"
            //            cell.ratingProgressBar.progress = Float(list2019[indexPath.item].voteAverage / 10)
            cell.descriptionLabel.text = list2019[indexPath.item].overview
            cell.releaseDateLabel.text = list2019[indexPath.item].releaseDate!.convertToDateFormat().convertToStringFormat()
            cell.downloadImage(fromURL: list2019[indexPath.item].posterPath)
        }
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            page += 1
            updateUI(for: page)
        }
    }
    
}

extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem - 150)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return sectionInsets.left
    }
}
