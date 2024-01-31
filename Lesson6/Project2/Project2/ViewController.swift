//
//  ViewController.swift
//  Project2
//
//  Created by User on 31.01.2024.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var GreenView: UIView!
    @IBOutlet weak var WhiteView: UIView!
    @IBOutlet weak var BlueView: UIView!
    
    private let userDefault: UserDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let rgb = userDefault.object(forKey: "backgroundColor") as? [CGFloat] {
            view.backgroundColor = UIColor(red: rgb[0], green: rgb[1], blue: rgb[2], alpha: 1)
        }
        
        GreenView.layer.borderWidth = 1
        GreenView.layer.borderColor = UIColor.black.cgColor
        
        WhiteView.layer.borderWidth = 1
        WhiteView.layer.borderColor = UIColor.black.cgColor
        
        BlueView.layer.borderWidth = 1
        BlueView.layer.borderColor = UIColor.black.cgColor
        
//        let tap = UITapGestureRecognizer(target: self, action: #selector(tapped(_:)))
        
        GreenView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapped(_:))))
        WhiteView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapped(_:))))
        BlueView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapped(_:))))
        
    }

    
    @objc func tapped(_ sender: UITapGestureRecognizer) {
        
        guard let color = sender.view?.layer.backgroundColor else {
            return
        }
        view.backgroundColor = UIColor(cgColor: color)
        
        userDefault.setValue(color.components, forKey: "backgroundColor")
        
    }

}

