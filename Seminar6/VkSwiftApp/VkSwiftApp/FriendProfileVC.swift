//
//  FriendProfileVC.swift
//  VkSwiftApp
//
//  Created by User on 08.02.2024.
//

import UIKit

class FriendProfileVC: UIViewController {

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
        setupViews()
        setupNetworkService()
                       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let theme: Theme = ThemeManager.shared.theme
        applyCurrentTheme(theme: theme)
    }
    
    private func setupViews() {
        view.addSubview(profilePhoto)
        profilePhoto.layer.cornerRadius = profilePhoto.frame.size.width / 2
        profilePhoto.layer.masksToBounds = true
        view.addSubview(nameLabel)
    }
    
    private func setupConstraints() {
        profilePhoto.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profilePhoto.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            profilePhoto.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profilePhoto.widthAnchor.constraint(equalToConstant: 150),
            profilePhoto.heightAnchor.constraint(equalToConstant: 150),
            nameLabel.topAnchor.constraint(equalTo: profilePhoto.bottomAnchor, constant: 20),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func setupNetworkService() {
        networkService.getProfileData(userID: userID) { [weak self] profile in
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
    
    func applyCurrentTheme(theme: Theme) {
        switch theme {
        case .light:
            view.backgroundColor = .white
            nameLabel.textColor = .black
        case .dark:
            view.backgroundColor = .black
            nameLabel.textColor = .white
        case .custom:
            view.backgroundColor = .gray
            nameLabel.textColor = .orange
        }
        ThemeManager.shared.updateTheme()
    }
}
