//
//  FriendTableViewCell.swift
//  VkSwiftApp
//
//  Created by User on 11.01.2024.
//

import UIKit

class FriendTableViewCell: UITableViewCell {

    private var circleView: UIImageView
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    
    private var onlineLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private var stackViewVertical: UIStackView
    
    private var stackViewHorizontal: UIStackView
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        circleView = UIImageView(image: UIImage(systemName: "circle"))
        stackViewVertical = UIStackView(arrangedSubviews: [nameLabel, onlineLabel])
        stackViewHorizontal = UIStackView(arrangedSubviews: [stackViewVertical])
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(circleView)
        setupStackViewVertical()
        setupStackViewHorizontal()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupStackViewVertical() {
        stackViewVertical.axis = .vertical
        stackViewVertical.alignment = .fill
        stackViewVertical.setCustomSpacing(0, after: nameLabel)
        contentView.addSubview(stackViewVertical)
    }
    
    private func setupStackViewHorizontal() {
        stackViewHorizontal.axis = .horizontal
        stackViewHorizontal.alignment = .fill
        stackViewHorizontal.setCustomSpacing(10, after: circleView)
        contentView.addSubview(stackViewHorizontal)
    }
    
    
    private func setupConstraints() {
        stackViewHorizontal.translatesAutoresizingMaskIntoConstraints = false
        stackViewVertical.translatesAutoresizingMaskIntoConstraints = false
        circleView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackViewVertical.leadingAnchor.constraint(equalTo: circleView.trailingAnchor),
            stackViewHorizontal.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackViewHorizontal.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            stackViewHorizontal.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackViewHorizontal.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            circleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            circleView.topAnchor.constraint(equalTo: contentView.topAnchor),
            circleView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func setup(firstName: String, lastName: String, online: Int16, photo_50: String) {
        let theme = ThemeManager.shared.theme
        
        nameLabel.text = "\(firstName) \(lastName)"
        
        switch theme {
        case .light:
            self.backgroundColor = .white
            nameLabel.textColor = .black
        case .dark:
            self.backgroundColor = .black
            nameLabel.textColor = .white
        case .custom:
            self.backgroundColor = .gray
            nameLabel.textColor = .orange
        }
        
        if (online == 1) {
            onlineLabel.text = "Online"
            onlineLabel.textColor = .green
        } else {
            onlineLabel.text = "Offline"
            onlineLabel.textColor = .red
        }
        let url = URL(string: photo_50)
        if let data = try? Data(contentsOf: url!) {
            circleView.image = UIImage(data: data)
            circleView.layer.cornerRadius = circleView.frame.size.width / 2
            circleView.layer.masksToBounds = true
        }
    }

}
