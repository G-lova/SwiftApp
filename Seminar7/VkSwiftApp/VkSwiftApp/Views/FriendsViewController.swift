//
//  FriendsViewController.swift
//  VkSwiftApp
//
//  Created by User on 04.01.2024.
//

import UIKit
import CoreData

class FriendsViewController: UITableViewController {
    
    var fileCache = FileCache()
    var fetchedResultsController: NSFetchedResultsController<FriendsModel>!
    var networkService = NetworkService()
    
    var friends: [FriendItems] = []
    
    //MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Friends"
        tabBarItem.title = "Friends"
        tableView.isScrollEnabled = true
        
        tableView.register(FriendTableViewCell.self, forCellReuseIdentifier: "friendCell")
        
        setupLoadFriendsFromCoreData()
        setupProfileButton()
        setupRefreshControl()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        applyCurrentTheme()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupNetworkService()
    }
    
    //MARK: - View Settings Methods
    
    //Setup ProfileButton Method
    
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
    
    // Setup RefreshControl Method
    
    func setupRefreshControl() {
        let dataRefresher: UIRefreshControl = {
            let refreshControl = UIRefreshControl()
            refreshControl.attributedTitle = NSAttributedString(string: "Updating...")
            refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
            return refreshControl
        }()
        tableView.refreshControl = dataRefresher
    }
    
    @objc func refreshData() {
        setupNetworkService()
        tableView.refreshControl?.endRefreshing()
    }
    
    // Change Vurrent Theme Method
    
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
    
    //MARK: - Data Methods
    
    func setupNetworkService() {
        networkService.getFriendsData(completion: { [weak self] friends in
            self?.friends = friends
            self?.setupLoadFriendsFromCoreData()
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }, errorHandler: { [weak self] in
            let friendsUpdatingDate = DateManager.shared.friendsUpdatingDate
            let alert = UIAlertController(title: "Error", message: "Error to update data. Last update: \(friendsUpdatingDate)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self?.present(alert, animated: true, completion: nil)
        })
    }
    
    func setupLoadFriendsFromCoreData() {
        fileCache.loadFriendsFromCoreData() { [weak self] fetchedResultsController in
            self?.fetchedResultsController = fetchedResultsController
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    //MARK: - TableViewDelegate Methods
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        friends.count
        return fetchedResultsController?.sections?[section].numberOfObjects ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendCell") as! FriendTableViewCell
//        let friend = friends[indexPath.row]
        let friend = fetchedResultsController.object(at: indexPath)
        cell.setup(firstName: friend.friendFirstName, lastName: friend.friendLastName, online: friend.isOnline, photo_50: friend.friendPhoto)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let friendProfileVC = FriendProfileVC()
        let friend = fetchedResultsController.object(at: indexPath)
        friendProfileVC.friendID = String(friend.friendID)
        navigationController?.pushViewController(friendProfileVC, animated: true)
    }
}

