//
//  ViewController.swift
//  VkSwiftApp
//
//  Created by User on 04.01.2024.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    
    private lazy var webView: WKWebView = {
        let webView = WKWebView(frame: view.frame)
        webView.navigationDelegate = self
        return webView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = .white
        view.addSubview(webView)
        guard let url = URL(string: "https://oauth.vk.com/authorize?client_id=51821877&redirect_uri=https://oauth.vk.com/blank.html&display=mobile&scope=friends,photos,groups&response_type=token") else {return}
        let request = URLRequest(url: url)
        webView.load(request)
        
    }

    
    func webView(_ webView: WKWebView,decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment else {
            decisionHandler(.allow)
            return
        }
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }
        let token = params["access_token"]
        let userID = params["user_id"]
//        print(token)
//       print(userID)
        decisionHandler(.cancel)
        webView.removeFromSuperview()
        let tabBarController = UITabBarController()
        
        let friendsViewController = FriendsViewController()
        if let token = token, let userID = userID {
            friendsViewController.token = token
            friendsViewController.userID = userID
        }
        let friendsVC = UINavigationController(rootViewController: friendsViewController)
        
        let groupsViewController = GroupsViewController()
        if let token = token, let userID = userID {
            groupsViewController.token = token
            groupsViewController.userID = userID
        }
        let groupsVC = UINavigationController(rootViewController: groupsViewController)
        
        let photosViewController = PhotosViewController(collectionViewLayout: getLayout())
        if let token = token, let userID = userID {
            photosViewController.token = token
            photosViewController.userID = userID
        }
        let photosVC = UINavigationController(rootViewController: photosViewController)
        
        friendsVC.tabBarItem.title = "Friends"
        groupsVC.tabBarItem.title = "Groups"
        photosVC.tabBarItem.title = "Photos"
        photosVC.view.backgroundColor = .white
        
        let controllers = [friendsVC, groupsVC, photosVC]
        tabBarController.viewControllers = controllers
        
        
        addChild(tabBarController)
        view.addSubview(tabBarController.view)
        tabBarController.didMove(toParent: self)
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
