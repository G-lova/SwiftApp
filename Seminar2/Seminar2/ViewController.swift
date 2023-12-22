//
//  ViewController.swift
//  Seminar2
//
//  Created by User on 19.12.2023.
//

import UIKit

class ViewController: UIViewController {
    
    private let logoImageView: UIImageView = {
        let logoImageView = UIImageView(image: UIImage(named: "logo.png"))
        return logoImageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Autorization"
        label.textAlignment = .center
        label.textColor = .black
        label.backgroundColor = .white
        return label
    }()
    
    private let loginField: UITextField = {
        let loginField = UITextField()
        loginField.placeholder = "Login"
        loginField.borderStyle = .roundedRect
        return loginField
    }()
    
    private let passwordField: UITextField = {
        let passwordField = UITextField()
        passwordField.placeholder = "Password"
        passwordField.borderStyle = .roundedRect
        return passwordField
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        button.setTitle("Sign in", for: .normal)
        button.backgroundColor = .blue
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        
    }
    
    private func setupViews() {
        view.addSubview(logoImageView)
        view.addSubview(label)
        view.addSubview(loginField)
        view.addSubview(passwordField)
        view.addSubview(button)
        setupConstraints()
        button.addTarget(self, action: #selector(tap), for: .touchUpInside)
    }

    private func setupConstraints() {
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        loginField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            logoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            logoImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            logoImageView.heightAnchor.constraint(equalToConstant: 130),
            label.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 20),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.widthAnchor.constraint(equalToConstant: view.frame.size.width / 1.5),
            label.heightAnchor.constraint(equalToConstant: 40),
            loginField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
            loginField.widthAnchor.constraint(equalToConstant: 200),
            loginField.heightAnchor.constraint(equalToConstant: 40),
            passwordField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordField.topAnchor.constraint(equalTo: loginField.bottomAnchor, constant: 20),
            passwordField.widthAnchor.constraint(equalToConstant: 200),
            passwordField.heightAnchor.constraint(equalToConstant: 40),
            button.topAnchor.constraint(equalTo: passwordField.bottomAnchor,constant: 20),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.widthAnchor.constraint(equalToConstant: 200),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60)
        ])
    }
    
    @objc func tap() {
        
        navigationController?.pushViewController(TabBarController(), animated: true)
    }

}


