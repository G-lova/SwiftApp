//
//  PhotosViewController.swift
//  Seminar2
//
//  Created by User on 20.12.2023.
//

import UIKit

private let reuseIdentifier = "Cell"

class PhotosViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Photos"
        //navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: "photoCell")
        
        

    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        6
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotoCollectionViewCell
    
        return cell
    }

    

}

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 10
        let collectionViewSize = collectionView.frame.size.width - padding
        return CGSize(width: collectionViewSize/2 - padding, height: collectionViewSize/2 - padding)
    }
    
}
