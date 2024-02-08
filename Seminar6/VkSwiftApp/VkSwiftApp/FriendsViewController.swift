//
//  FriendsViewController.swift
//  VkSwiftApp
//
//  Created by User on 04.01.2024.
//

import UIKit
//import CoreData

class FriendsViewController: UITableViewController {
    
    var networkService = NetworkService()
    
    var friends: [FriendItems] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Friends"
        tabBarItem.title = "Friends"
        tableView.isScrollEnabled = true
        
        tableView.register(FriendTableViewCell.self, forCellReuseIdentifier: "friendCell")
        
        setupNetworkService()
        setupProfileButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        applyCurrentTheme()
    }
    
    func setupProfileButton() {
        let profileButton = UIButton(type: .custom)
        profileButton.setTitle("Profile", for: .normal)
        let theme = ThemeManager.shared.theme
        switch theme {
        case .light:
            profileButton.setTitleColor(.black, for: .normal)
        case .dark:
            profileButton.setTitleColor(.white, for: .normal)
        case .custom:
            profileButton.setTitleColor(.orange, for: .normal)
        }
        profileButton.addTarget(self, action: #selector(profileButtonTapped), for: .touchUpInside)
        
        let profileBarButtonItem = UIBarButtonItem(customView: profileButton)
        navigationItem.rightBarButtonItem = profileBarButtonItem
    }
    
    @objc func profileButtonTapped() {
        let profileViewController = ProfileViewController()
        
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        animation.type = .fade
        animation.duration = 3
        navigationController?.view.layer.add(animation, forKey: nil)
        navigationController?.pushViewController(profileViewController, animated: false)
    }
    
    func setupNetworkService() {
        
        networkService.getFriendsData() { [weak self] friends in
            self?.friends = friends
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    func applyCurrentTheme() {
        let theme = ThemeManager.shared.theme
        switch theme {
        case .light:
            tableView.backgroundColor = .white
        case .dark:
            tableView.backgroundColor = .black
        case .custom:
            tableView.backgroundColor = .gray
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        friends.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendCell") as! FriendTableViewCell
        let friend = friends[indexPath.row]
        cell.setup(firstName: friend.first_name, lastName: friend.last_name, online: friend.online, photo_50: friend.photo_50)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let friendProfileVC = FriendProfileVC()
        friendProfileVC.userID = String(friends[indexPath.row].id)
        navigationController?.pushViewController(friendProfileVC, animated: true)
    }
}

