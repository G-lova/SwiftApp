//
//  AccessManager.swift
//  VkSwiftApp
//
//  Created by User on 03.02.2024.
//

import UIKit

class AccessManager {
    
    static let shared = AccessManager()
    
    var token: String {
        get {
            return UserDefaults.standard.string(forKey: "access_token") ?? ""
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "access_token")
        }
    }
    
    var userID: String {
        get {
            return UserDefaults.standard.string(forKey: "user_id") ?? ""
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "user_id")
        }
    }
}

