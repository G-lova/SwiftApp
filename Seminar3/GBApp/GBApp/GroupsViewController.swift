//
//  GroupsViewController.swift
//  GBApp
//
//  Created by User on 30.12.2023.
//

import UIKit

class GroupsViewController: UITableViewController {
    
    var token: String?
    var userID: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Groups"
        //navigationController?.navigationBar.prefersLargeTitles = true
        tabBarItem.title = "Groups"
        tableView.register(GroupTableViewCell.self, forCellReuseIdentifier: "groupCell")
        
        let network = NetworkService()
        network.getGroupsData(token: token, userID: userID)
        
    }

}

extension GroupsViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        UITableView.automaticDimension
    }
    
    override func tableView(_ tableView:UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell") as! GroupTableViewCell
        
        return cell
    }
}
