//
//  NewViewController.swift
//  Seminar5
//
//  Created by User on 22.01.2024.
//

import UIKit

class NewViewController: UIViewController {

    private let viewToAnimate: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitleColor(.blue, for: .normal)
        button.setTitle("Start", for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(button)
        view.addSubview(viewToAnimate)
        setupConstraints()
        button.addTarget(self, action: #selector(tap), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        viewToAnimate.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            viewToAnimate.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            viewToAnimate.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            viewToAnimate.widthAnchor.constraint(equalToConstant: 200),
            viewToAnimate.heightAnchor.constraint(equalToConstant: 200),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            button.widthAnchor.constraint(equalToConstant: 150),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func tap() {
        UIView.animate(withDuration: 1, delay: 0, options: [.autoreverse, .repeat]) {
            self.viewToAnimate.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            self.viewToAnimate.transform = CGAffineTransform(rotationAngle: .pi/4)
        }
        UIView.animate(withDuration: 3, delay: 1, options: [.autoreverse, .repeat]) {
            self.viewToAnimate.layer.opacity = 0
        }
    }

}
