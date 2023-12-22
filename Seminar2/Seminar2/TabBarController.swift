//
//  TabBarController.swift
//  Seminar2
//
//  Created by User on 20.12.2023.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        
    }
    
    private func setupTabBar() {
        let friendsVC = UINavigationController(rootViewController: FriendsViewController())
        let groupsVC = UINavigationController(rootViewController: GroupsViewController())
        let photosVC = UINavigationController(rootViewController: PhotosViewController(collectionViewLayout: getLayout()))
        friendsVC.tabBarItem.title = "Friends"
        groupsVC.tabBarItem.title = "Groups"
        photosVC.tabBarItem.title = "Photos"
        photosVC.view.backgroundColor = .white
        
        let controllers = [friendsVC, groupsVC, photosVC]
        viewControllers = controllers
        
    }
    
    private func getLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(view.frame.size.height/4.2))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }

}

