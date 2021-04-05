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
    
    override func viewWillDisappear(_ animated: Bool) {
        ImageLoader.shared.empty()
    }
    
    func updateUI(for page: Int) {
        
        NetworkManager.shared.getMovies() { [weak self] (result) in
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
        print("qty 2019: \(self.list2019.count)")
        return list2019.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
        
        guard !list2019.isEmpty else {return cell}
 
        cell.setup(with: list2019[indexPath.item])
            
        return cell
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
