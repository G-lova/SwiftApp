//
//  GroupsViewController.swift
//  VkSwiftApp
//
//  Created by User on 04.01.2024.
//

import UIKit
import CoreData

class GroupsViewController: UITableViewController {
    
    var fetchedResultsController: NSFetchedResultsController<GroupModel>!
    
    var groups: [GroupsItems] = []
    
    var networkService = NetworkService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Groups"
        tabBarItem.title = "Groups"
        tableView.register(GroupTableViewCell.self, forCellReuseIdentifier: "groupCell")
        
//        setupNetworkService()
        loadGroupsFromCoreData()
        setupRefreshControl()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        applyCurrentTheme()
    }
    
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
//        tableView.reloadData()
    }
    
    func setupNetworkService() {
        networkService.getGroupsData { [weak self] groups in
            self?.groups = groups
            self?.loadGroupsFromCoreData()
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    func loadGroupsFromCoreData() {
        let fileCache = FileCache()
        
        let fetchRequest: NSFetchRequest<GroupModel> = GroupModel.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "groupName", ascending: true)]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: fileCache.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        do {
            try fetchedResultsController.performFetch()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            print(error)
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
}


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
