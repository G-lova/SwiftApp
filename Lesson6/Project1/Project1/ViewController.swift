//
//  ViewController.swift
//  Project1
//
//  Created by User on 01.02.2024.
//

import UIKit

class ViewController: UITableViewController {

    private var towns: [Town] = []
    private let networkService = NetworkService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "Cell")
        
        let userDefault = UserDefaults.standard
        
        if let towns = userDefault.data(forKey: "towns") {
            guard let data = try? PropertyListDecoder().decode([Town].self, from: towns) else {
                return
            }
            self.towns = data
            print("userDefault", self.towns)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        
        networkService.getData { [weak self] towns in
            self?.towns = towns
            if let data = try? PropertyListEncoder().encode(towns) {
                userDefault.setValue(data, forKey: "towns")
            }
            
            
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        towns.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! CustomTableViewCell
//        guard let cell = cell as? CustomTableViewCell else {
//            return UITableViewCell()
//        }
        let town = towns[indexPath.row]
        cell.setup(nameTown: town.townName, lat: town.coords.lat, lon: town.coords.lon)
        return cell
    }
    

}


