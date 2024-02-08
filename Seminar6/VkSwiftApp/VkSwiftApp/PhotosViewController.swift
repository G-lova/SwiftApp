//
//  PhotosViewController.swift
//  VkSwiftApp
//
//  Created by User on 04.01.2024.
//

import UIKit

class PhotosViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var photos: [PhotoItems] = []
    
    private var photoImages: [UIImage] = []

    private let reuseIdentifier = "photoCell"
    
    var networkService = NetworkService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Photos"
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: "photoCell")
        
        setupNetworkService()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        applyCurrentTheme()
    }
    
    func setupNetworkService() {
        networkService.getPhotosData{ [weak self] photos in
            self?.photos = photos
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
    
    func applyCurrentTheme() {
        let theme = ThemeManager.shared.theme
        switch theme {
        case .light:
            collectionView.backgroundColor = .white
        case .dark:
            collectionView.backgroundColor = .black
        case .custom:
            collectionView.backgroundColor = .gray
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotoCollectionViewCell
        let photo = photos[indexPath.row]
        cell.setupImage(photo_50: photo.url)
        return cell
    }

}
