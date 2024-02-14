//
//  GroupsViewController.swift
//  VkSwiftApp
//
//  Created by User on 04.01.2024.
//

import UIKit
import CoreData

class GroupsViewController: UITableViewController {
    
    let fileCache = FileCache()
    var fetchedResultsController: NSFetchedResultsController<GroupModel>!
    var networkService = NetworkService()
    
    var groups: [GroupsItems] = []
    
    // MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Groups"
        tabBarItem.title = "Groups"
        tableView.register(GroupTableViewCell.self, forCellReuseIdentifier: "groupCell")
        
        setupLoadGroupsFromCoreData()
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
    
    // Change Current Theme Method
    
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
        networkService.getGroupsData { [weak self] groups in
            self?.groups = groups
            self?.setupLoadGroupsFromCoreData()
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }

    func setupLoadGroupsFromCoreData() {
        fileCache.loadGroupsFromCoreData() { [weak self] fetchedResultsController in
            self?.fetchedResultsController = fetchedResultsController
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}

//MARK: - TableViewDelegate Methods

extension GroupsViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        groups.count
        return fetchedResultsController?.sections?[section].numberOfObjects ?? 0
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        UITableView.automaticDimension
    }
    
    override func tableView(_ tableView:UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell") as! GroupTableViewCell
//        let group = groups[indexPath.row]
        let group = fetchedResultsController.object(at: indexPath)
        cell.setup(nameGroup: group.groupName, description: group.groupDescription, photo_50: group.groupPhoto)
        return cell
    }
}
