//
//  ViewController.swift
//  Lesson7
//
//  Created by User on 31.01.2024.
//

import UIKit

class ViewController: UIViewController, ViewControllerProtocol {
    
    private var interactor: InteractorProtocol
    
    init(interactor: InteractorProtocol) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    func updateScreen() {
        interactor.updateScreen()
    }

}

