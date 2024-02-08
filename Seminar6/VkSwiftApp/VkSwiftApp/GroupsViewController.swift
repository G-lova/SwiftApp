//
//  GroupsViewController.swift
//  VkSwiftApp
//
//  Created by User on 04.01.2024.
//

import UIKit

class GroupsViewController: UITableViewController {
    
    var groups: [GroupsItems] = []
    
    var networkService = NetworkService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Groups"
        tabBarItem.title = "Groups"
        tableView.register(GroupTableViewCell.self, forCellReuseIdentifier: "groupCell")
        
        setupNetworkService()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        applyCurrentTheme()
    }
    
    func setupNetworkService() {
        networkService.getGroupsData { [weak self] groups in
            self?.groups = groups
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
}


extension GroupsViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        groups.count
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        UITableView.automaticDimension
    }
    
    override func tableView(_ tableView:UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell") as! GroupTableViewCell
        let group = groups[indexPath.row]
        cell.setup(nameGroup: group.name, description: group.description, photo_50: group.photo_50)
        return cell
    }
}
