//
//  GroupTableViewCell.swift
//  VkSwiftApp
//
//  Created by User on 04.01.2024.
//

import UIKit
//import SDWebImage

class GroupTableViewCell: UITableViewCell {
    
    private var picView: UIImageView {
        let picView = UIImageView(image: UIImage(systemName: "circle"))
        return picView
    }
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        return label
    }()
    
    private var stackViewVertical: UIStackView
    
    private var stackViewHorizontal: UIStackView
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        stackViewVertical = UIStackView(arrangedSubviews: [nameLabel, descriptionLabel])
        stackViewHorizontal = UIStackView(arrangedSubviews: [stackViewVertical])
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        setupView()
        contentView.addSubview(picView)
        setupStackViewVertical()
        setupStackViewHorizontal()
//        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    private func setupView() {
//        contentView.addSubview(nameLabel)
//        contentView.addSubview(descriptionLabel)
//        contentView.addSubview(picView)
//    }
    
    private func setupStackViewVertical() {
        stackViewVertical.axis = .vertical
        stackViewVertical.alignment = .fill
        stackViewVertical.setCustomSpacing(0, after: nameLabel)
        contentView.addSubview(stackViewVertical)
    }
    
    private func setupStackViewHorizontal() {
        stackViewHorizontal.axis = .horizontal
        stackViewHorizontal.alignment = .fill
        stackViewHorizontal.setCustomSpacing(10, after: picView)
        contentView.addSubview(stackViewHorizontal)
    }
    
    
    private func setupConstraints() {
        stackViewVertical.translatesAutoresizingMaskIntoConstraints = false
        stackViewHorizontal.translatesAutoresizingMaskIntoConstraints = false
        picView.translatesAutoresizingMaskIntoConstraints = false
//        nameLabel.translatesAutoresizingMaskIntoConstraints = false
//        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackViewVertical.leadingAnchor.constraint(equalTo: picView.trailingAnchor, constant: 10),
            stackViewHorizontal.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackViewHorizontal.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            stackViewHorizontal.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackViewHorizontal.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            picView.widthAnchor.constraint(equalTo: picView.heightAnchor),
            picView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            picView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
//            nameLabel.leadingAnchor.constraint(equalTo: picView.trailingAnchor, constant: 10),
//            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
//            descriptionLabel.leadingAnchor.constraint(equalTo: picView.trailingAnchor, constant: 10),
//            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
//            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    func setup(nameGroup: String, description: String?) {
        nameLabel.text = nameGroup
        guard let description = description else { return }
        descriptionLabel.text = description
//        guard let photo_50 = photo_50 else { return }
//        let url = URL(string: photo_50)
//        if let data = try? Data(contentsOf: url!) {
//            picView.image = UIImage(data: data)
//        }
    }
}
