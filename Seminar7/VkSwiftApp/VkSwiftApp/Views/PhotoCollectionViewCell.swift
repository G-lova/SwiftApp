//
//  PhotoCollectionViewCell.swift
//  VkSwiftApp
//
//  Created by User on 04.01.2024.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView.frame = CGRect(x: 5, y: 5, width: contentView.frame.size.width - 10, height: contentView.frame.size.height - 20)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        contentView.addSubview(imageView)
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
        let theme = ThemeManager.shared.theme
        
        switch theme {
        case .light:
            self.backgroundColor = .white
        case .dark:
            self.backgroundColor = .black
        case .custom:
            self.backgroundColor = .gray
        }
    }
}
