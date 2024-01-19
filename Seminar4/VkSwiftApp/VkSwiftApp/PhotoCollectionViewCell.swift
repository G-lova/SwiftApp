//
//  PhotoCollectionViewCell.swift
//  VkSwiftApp
//
//  Created by User on 04.01.2024.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    private var imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: contentView.frame.size.width, height: contentView.frame.size.height))
//        imageView.image = UIImage(systemName: "person")
//        setupCellView()
//        imageView.backgroundColor = .white
        addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    func setupImage(photo_50: String) {
        let url = URL(string: photo_50)
        if let data = try? Data(contentsOf: url!) {
            self.imageView.image = UIImage(data: data)
        }
    }
}
