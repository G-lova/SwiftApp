//
//  TabBarController.swift
//  VkSwiftApp
//
//  Created by User on 03.02.2024.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let friendsViewController = FriendsViewController()
        let friendsVC = UINavigationController(rootViewController: friendsViewController)
        
        let groupsViewController = GroupsViewController()
        let groupsVC = UINavigationController(rootViewController: groupsViewController)
        
        let photosViewController = PhotosViewController(collectionViewLayout: getLayout())
        let photosVC = UINavigationController(rootViewController: photosViewController)
        
        friendsVC.tabBarItem.title = "Friends"
        groupsVC.tabBarItem.title = "Groups"
        photosVC.tabBarItem.title = "Photos"
        
        let theme = ThemeManager.shared.theme
        switch theme {
        case .light:
            friendsVC.navigationBar.backgroundColor = .white
            groupsVC.navigationBar.backgroundColor = .white
            photosVC.navigationBar.backgroundColor = .white
        case .dark:
            friendsVC.navigationBar.backgroundColor = .black
            groupsVC.navigationBar.backgroundColor = .black
            photosVC.navigationBar.backgroundColor = .black
        case .custom:
            friendsVC.navigationBar.backgroundColor = .gray
            groupsVC.navigationBar.backgroundColor = .gray
            photosVC.navigationBar.backgroundColor = .gray
        }
        
        viewControllers = [friendsVC, groupsVC, photosVC]
           
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let theme = ThemeManager.shared.theme
        applyCurrentTheme(theme: theme)
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
    
    func applyCurrentTheme(theme: Theme) {
        switch theme {
        case .light:
            view.backgroundColor = .white
            tabBar.backgroundColor = .white
            tabBarItem.badgeColor = .black
        case .dark:
            view.backgroundColor = .black
            tabBar.backgroundColor = .black
            tabBarItem.badgeColor = .white
        case .custom:
            view.backgroundColor = .gray
            tabBar.backgroundColor = .gray
            tabBarItem.badgeColor = .orange
        }
    }

}
