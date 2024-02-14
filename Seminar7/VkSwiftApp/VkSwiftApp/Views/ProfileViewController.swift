//
//  ProfileViewController.swift
//  VkSwiftApp
//
//  Created by User on 24.01.2024.
//

import UIKit

class ProfileViewController: UIViewController {
    
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
    
    private let themeLabel: UILabel = {
        let label = UILabel()
        label.text = "Choose the App's theme:"
        return label
    }()
    
    private let lightThemeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Light Theme", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderWidth = 1
        button.backgroundColor = .white
        return button
    }()
    
    private let darkThemeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Dark Theme", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.borderWidth = 1
        button.backgroundColor = .black
        return button
    }()
    
    private let customThemeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Custom Theme", for: .normal)
        button.setTitleColor(.orange, for: .normal)
        button.layer.borderWidth = 1
        button.backgroundColor = .gray
        return button
    }()

    //MARK: - Life Cycle Methods
    
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
    
    //MARK: - View Settings Methods
    
    private func setupViews() {
        view.addSubview(profilePhoto)
        profilePhoto.layer.cornerRadius = profilePhoto.frame.size.width / 2
        profilePhoto.layer.masksToBounds = true
        view.addSubview(nameLabel)
        view.addSubview(themeLabel)
        view.addSubview(lightThemeButton)
        lightThemeButton.addTarget(self, action: #selector(lightThemeSelected), for: .touchUpInside)
        view.addSubview(darkThemeButton)
        darkThemeButton.addTarget(self, action: #selector(darkThemeSelected), for: .touchUpInside)
        view.addSubview(customThemeButton)
        customThemeButton.addTarget(self, action: #selector(customThemeSelected), for: .touchUpInside)
        setupConstraints()
    }
    
    private func setupConstraints() {
        profilePhoto.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        themeLabel.translatesAutoresizingMaskIntoConstraints = false
        lightThemeButton.translatesAutoresizingMaskIntoConstraints = false
        darkThemeButton.translatesAutoresizingMaskIntoConstraints = false
        customThemeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profilePhoto.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            profilePhoto.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profilePhoto.widthAnchor.constraint(equalToConstant: 150),
            profilePhoto.heightAnchor.constraint(equalToConstant: 150),
            nameLabel.topAnchor.constraint(equalTo: profilePhoto.bottomAnchor, constant: 20),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            themeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            themeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            themeLabel.heightAnchor.constraint(equalToConstant: 50),
            lightThemeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lightThemeButton.topAnchor.constraint(equalTo: themeLabel.bottomAnchor, constant: 0),
            lightThemeButton.widthAnchor.constraint(equalToConstant: 150),
            darkThemeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            darkThemeButton.topAnchor.constraint(equalTo: lightThemeButton.bottomAnchor, constant: 20),
            darkThemeButton.widthAnchor.constraint(equalToConstant: 150),
            customThemeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            customThemeButton.topAnchor.constraint(equalTo: darkThemeButton.bottomAnchor, constant: 20),
            customThemeButton.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    @objc func lightThemeSelected() {
        let selectedTheme: Theme = .light
        ThemeManager.shared.theme = selectedTheme
        applyCurrentTheme(theme: selectedTheme)
    }
    
    @objc func darkThemeSelected() {
        let selectedTheme: Theme = .dark
        ThemeManager.shared.theme = selectedTheme
        applyCurrentTheme(theme: selectedTheme)
    }
    
    @objc func customThemeSelected() {
        let selectedTheme: Theme = .custom
        ThemeManager.shared.theme = selectedTheme
        applyCurrentTheme(theme: selectedTheme)
    }
    
    func applyCurrentTheme(theme: Theme) {
        switch theme {
        case .light:
            view.backgroundColor = .white
            nameLabel.textColor = .black
            themeLabel.textColor = .black
            lightThemeButton.layer.borderColor = CGColor.init(red: 0, green: 0, blue: 0, alpha: 1)
        case .dark:
            view.backgroundColor = .black
            nameLabel.textColor = .white
            themeLabel.textColor = .white
            darkThemeButton.layer.borderColor = CGColor.init(red: 1, green: 1, blue: 1, alpha: 1)
        case .custom:
            view.backgroundColor = .gray
            nameLabel.textColor = .orange
            themeLabel.textColor = .orange
            customThemeButton.layer.borderColor = CGColor.init(red: 0, green: 0, blue: 0, alpha: 1)
        }
        ThemeManager.shared.updateTheme()
    }
    
    //MARK: - Data Methods
    
    func setupNetworkService() {
        let userID = AccessManager.shared.userID
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
}
