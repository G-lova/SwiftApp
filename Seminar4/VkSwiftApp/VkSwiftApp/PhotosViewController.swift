//
//  PhotosViewController.swift
//  VkSwiftApp
//
//  Created by User on 04.01.2024.
//

import UIKit

class PhotosViewController: UICollectionViewController {
        
    var token: String = ""
    var userID: String = ""
    
    var photos: [PhotoItems] = []

    private let reuseIdentifier = "photoCell"
    
    var networkService = NetworkService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Photos"
        //navigationController?.navigationBar.prefersLargeTitles = true
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: "photoCell")
        
        networkService.token = token
        networkService.userID = userID
        networkService.getPhotosData{ [weak self] photos in
            self?.photos = photos
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }

    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotoCollectionViewCell
        let photo = photos[indexPath.row]
        cell.setupImage(photoUrl: photo.url)
    
        return cell
    }

}

//extension PhotosViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let padding: CGFloat = 10
//        let collectionViewSize = collectionView.frame.size.width - padding
//        return CGSize(width: collectionViewSize/2 - padding, height: collectionViewSize/2 - padding)
//    }
//    
//}
