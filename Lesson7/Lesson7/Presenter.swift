//
//  Presenter.swift
//  Lesson7
//
//  Created by User on 31.01.2024.
//

//import Foundation
import UIKit

class Presenter: PresenterProtocol {
    
    weak var viewController: ViewControllerProtocol?
    

    func updateScreen() {
        viewController?.updateScreen()
    }
}
