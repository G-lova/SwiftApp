//
//  ViewController.swift
//  VkSwiftApp
//
//  Created by User on 04.01.2024.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    
    
    private let theme: ThemeManager = ThemeManager.shared
    
    private lazy var webView: WKWebView = {
        let webView = WKWebView(frame: view.frame)
        webView.navigationDelegate = self
        return webView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        theme.applyTheme(ThemeManager.shared.theme)
        
        view.addSubview(webView)
        guard let url = URL(string: "https://oauth.vk.com/authorize?client_id=51821877&redirect_uri=https://oauth.vk.com/blank.html&display=mobile&scope=friends,photos,groups&response_type=token") else {return}
        let request = URLRequest(url: url)
        webView.load(request)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        applyCurrentTheme()
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
        
        let accessManager = AccessManager.shared
        if let token = token, let userID = userID {
            accessManager.token = token
            accessManager.userID = userID
        }
        
        decisionHandler(.cancel)
        webView.removeFromSuperview()
        
        let tabBarController = TabBarController()
        
        addChild(tabBarController)
        view.addSubview(tabBarController.view)
        tabBarController.didMove(toParent: self)
    }
    
    func applyCurrentTheme() {
        let theme = ThemeManager.shared.theme
        switch theme {
        case .light:
            view.backgroundColor = .white
        case .dark:
            view.backgroundColor = .black
        case .custom:
            view.backgroundColor = .gray
        }
    }
}
