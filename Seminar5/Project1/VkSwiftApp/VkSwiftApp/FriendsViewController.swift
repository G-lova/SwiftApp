//
//  FriendsViewController.swift
//  VkSwiftApp
//
//  Created by User on 04.01.2024.
//

import UIKit

class FriendsViewController: UITableViewController {
    
    var token: String = ""
    var userID: String = ""
    
    var networkService = NetworkService()
    
    var friends: [FriendItems] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Friends"
        tabBarItem.title = "Friends"
        tableView.isScrollEnabled = true
        
        tableView.register(FriendTableViewCell.self, forCellReuseIdentifier: "friendCell")
        setupProfileButton()
        setupNetworkService()
    }
    
    func setupProfileButton() {
        let profileButton = UIButton(type: .custom)
        profileButton.setTitle("Profile", for: .normal)
        profileButton.setTitleColor(.black, for: .normal)
        profileButton.addTarget(self, action: #selector(profileButtonTapped), for: .touchUpInside)
        
        let profileBarButtonItem = UIBarButtonItem(customView: profileButton)
        navigationItem.rightBarButtonItem = profileBarButtonItem
    }
    
    @objc func profileButtonTapped() {
        let profileViewController = ProfileViewController()
        profileViewController.token = self.token
        profileViewController.userID = self.userID
        
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        animation.type = .fade
        animation.duration = 3
        navigationController?.view.layer.add(animation, forKey: nil)
        navigationController?.pushViewController(profileViewController, animated: false)
    }
    
    func setupNetworkService() {
        networkService.token = token
        networkService.userID = userID
        networkService.getFriendsData() { [weak self] friends in
            self?.friends = friends
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
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
}

