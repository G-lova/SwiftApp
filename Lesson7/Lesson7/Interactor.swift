//
//  Interactor.swift
//  Lesson7
//
//  Created by User on 31.01.2024.
//

//import Foundation
import UIKit

enum NumberOfCharacters {
    case first, last, all
}

class Interactor: InteractorProtocol {
    
    private var presenter: PresenterProtocol
    
    init(presenter:PresenterProtocol) {
        self.presenter = presenter
    }
    
    func updateScreen() {
        presenter.updateScreen()
    }
    
    internal func getNumber(num: Int) -> Int {
        var result = num
        if num > 10 {
            result *= 3
        } else {
            result -= 3
        }
        return result
    }
    
    internal func getCharacters (currentString:String?, countCharacters: NumberOfCharacters) -> [Character] {
        guard let currentString = currentString, !currentString.isEmpty else {
            return []
        }
        var characters: [Character?] = []
        switch countCharacters {
        case .all: characters = Array(currentString)
        case .first: characters.append(currentString.first)
        case .last: characters.append(currentString.last)
        }
        return characters.compactMap{$0}
    }
    
    internal func hasStrin(stringForCheck: String, checkString: String) {
        if stringForCheck.contains(checkString) {
            presenter.updateScreen()
        }
    }
    
}
