//
//  PhotosViewController.swift
//  VkSwiftApp
//
//  Created by User on 04.01.2024.
//

import UIKit

class PhotosViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var photoImages: [UIImage] = []

    private let reuseIdentifier = "photoCell"
    
    var networkService = NetworkService()
    
    //MARK: - Life Cycle Methods
    
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
    
    //MARK: - Data Methods
    
    func setupNetworkService() {
        networkService.getPhotosData{ [weak self] photoImages in
//            self?.photos = photos
            self?.photoImages = photoImages
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
        }
    }
    
    //MARK: - Change Current Theme Metod
    
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
    
    //MARK: - CollectionViewDelegate Methods
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photoImages.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotoCollectionViewCell
        let photoImage = photoImages[indexPath.row]
        cell.setupImage(image: photoImage)
        return cell
    }

}
