//
//  DateManager.swift
//  VkSwiftApp
//
//  Created by User on 12.02.2024.
//

import UIKit

class DateManager {
    
    static let shared = DateManager()
    
    var friendsUpdatingDate: Date {
        get {
            return UserDefaults.standard.object(forKey: "friendsUpdatingDate") as! Date
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "friendsUpdatingDate")
        }
    }
    
    var groupsUpdatingDate: Date {
        get {
            return UserDefaults.standard.object(forKey: "groupsUpdatingDate") as! Date
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "groupsUpdatingDate")
        }
    }
}


