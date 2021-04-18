//
//  CollectionViewController.swift
//  TDT
//
//  Created by Sergei Krupenikov on 30.03.2021.
//

import UIKit

class MovieCollectionViewController: UICollectionViewController {
    
    private let sectionInsets = UIEdgeInsets(
        top: 10.0,
        left: 20.0,
        bottom: 10.0,
        right: 20.0)
    private let itemsPerRow: CGFloat = 1
    var page = 1
    var list: [Movie] = []
    var selectedMovie : Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.alwaysBounceVertical = true
        title = "Top 2019 Movies"
        
        update(for: page)
    }
    
    func update(for page: Int) {
        NetworkManager.shared.getMovies(for: page) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let movies):
                self.list += movies.results
                self.collectionView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
        
    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.reuseIdentifier, for: indexPath) as! MovieCollectionViewCell
        guard !list.isEmpty else {
            return cell
        }
        cell.setup(with: list[indexPath.item])
        cell.delegate = self
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destVC = segue.destination as? DateViewController {
            destVC.movie = self.selectedMovie
        }
    }
    
    // MARK: UICollectionViewDelegate
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            page += 1
            update(for: page)
        }
    }
}

extension MovieCollectionViewController: MovieCollectionViewCellDelegate {
    func collectionViewCell(_ collectionViewCell: MovieCollectionViewCell, didSelectMovie movie: Movie) {
         self.selectedMovie = movie
        print(movie.title)
        performSegue(withIdentifier: "dateSegue", sender: nil)
    }
}

extension MovieCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        // TODO: 150 - magic constant
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
