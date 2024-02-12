//
//  ThemeManager.swift
//  VkSwiftApp
//
//  Created by User on 01.02.2024.
//

import UIKit

enum Theme: String {
    case light
    case dark
    case custom
}

class ThemeManager {
    static let shared = ThemeManager()
    
    var theme: Theme {
        get {
            var currentTheme: Theme = .light
            if let storedTheme = UserDefaults.standard.string(forKey: "selectedTheme") {
                currentTheme = Theme(rawValue: storedTheme) ?? .light
                applyTheme(currentTheme)
                return currentTheme
            } else {
                applyTheme(currentTheme)
                return currentTheme
            }
        }
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: "selectedTheme")
            applyTheme(newValue)
        }
    }
    
    func applyTheme(_ theme: Theme) {
        switch theme {
        case .light:
            UIApplication.shared.windows.forEach { window in
                window.overrideUserInterfaceStyle = .light
            }
            updateTheme()
        case .dark:
            UIApplication.shared.windows.forEach { window in
                window.overrideUserInterfaceStyle = .dark
            }
            updateTheme()
        case .custom:
            updateTheme()
        }
    }
    
    func updateTheme() {
        UIApplication.shared.windows.forEach { window in
            window.setNeedsDisplay()
            window.setNeedsLayout()
        }
    }
}

extension UIColor {
    static var customBackgroundColor: UIColor = .gray
    static var customTextColor: UIColor = .orange
}


