//
//  FirstViewController.swift
//  Contest
//
//  Created by Souley on 17/01/2019.
//  Copyright © 2019 Souley. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    let secondViewController = SecondViewController()
    
    let enterEmailLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Please Enter Your Email Address"
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .white
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let emailEntryTextField: UITextField = {
        let textField = UITextField()
        
        textField.placeholder = "Email Address"
        textField.backgroundColor = .white
        
        textField.clipsToBounds = true
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    let sumbitEmailAddressButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("Submit", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(.purple, for: .normal)
        
        button.layer.cornerRadius = 15
        button.clipsToBounds = true 
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .purple
        
        setupLayout()
        setupActions()
    }
    
    @objc func submitButtonTapped() {
        if emailEntryTextField.text?.isEmpty == true {
            UIView.animate(withDuration: 0.25, animations: {
                self.emailEntryTextField.transform = CGAffineTransform(translationX: -10, y: 0)
                self.emailEntryTextField.transform = CGAffineTransform(translationX: 10, y: 0)
            }) { (_) in
                self.emailEntryTextField.transform = CGAffineTransform.identity
            }
        } else {
            show(secondViewController, sender: self)
        }
    }
    
    func setupActions() {
        sumbitEmailAddressButton.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
    }
    
    func setupLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        view.addSubview(enterEmailLabel)
        view.addSubview(emailEntryTextField)
        view.addSubview(sumbitEmailAddressButton)
        
        enterEmailLabel.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
        enterEmailLabel.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor, constant: -30).isActive = true
        
        emailEntryTextField.topAnchor.constraint(equalTo: enterEmailLabel.bottomAnchor, constant: 20).isActive = true
        emailEntryTextField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 30).isActive = true
        emailEntryTextField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -30).isActive = true
        emailEntryTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        sumbitEmailAddressButton.topAnchor.constraint(equalTo: emailEntryTextField.bottomAnchor, constant: 20).isActive = true
        sumbitEmailAddressButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 50).isActive = true
        sumbitEmailAddressButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -50).isActive = true
        sumbitEmailAddressButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
}
