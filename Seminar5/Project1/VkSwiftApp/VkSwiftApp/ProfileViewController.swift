//
//  ProfileViewController.swift
//  VkSwiftApp
//
//  Created by User on 24.01.2024.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var token: String = ""
    var userID: String = ""
    
    var networkService = NetworkService()
    
    var profile: [ProfileItems] = []
    
    private let profilePhoto: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "person"))
        return image
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        view.backgroundColor = .white
        setupViews()
        setupNetworkService()
        
    }
    
    private func setupViews() {
        view.addSubview(profilePhoto)
        profilePhoto.layer.cornerRadius = profilePhoto.frame.size.width / 2
        profilePhoto.layer.masksToBounds = true
        view.addSubview(nameLabel)
        setupConstraints()
    }
    
    private func setupConstraints() {
        profilePhoto.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profilePhoto.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            profilePhoto.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profilePhoto.widthAnchor.constraint(equalToConstant: 200),
            profilePhoto.heightAnchor.constraint(equalToConstant: 200),
            nameLabel.topAnchor.constraint(equalTo: profilePhoto.bottomAnchor, constant: 20),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func setupNetworkService() {
        networkService.token = token
        networkService.userID = userID
        networkService.getProfileData() { [weak self] profile in
            self?.profile = profile
            DispatchQueue.main.async {
                let url = URL(string: profile[0].photo_200)
                if let data = try? Data(contentsOf: url!) {
                    self?.profilePhoto.image = UIImage(data: data)
                    self?.nameLabel.text = "\(profile[0].first_name) \(profile[0].last_name)"
                }
            }
        }
    }

}
