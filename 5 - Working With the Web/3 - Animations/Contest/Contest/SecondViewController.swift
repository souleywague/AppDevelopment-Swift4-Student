//
//  SecondViewController.swift
//  Contest
//
//  Created by Souley on 17/01/2019.
//  Copyright © 2019 Souley. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    let winningLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Congratulations You Won The Contest!"
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .white
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue
        
        setupLayout()
    }
    
    func setupLayout() {
    let safeArea = view.safeAreaLayoutGuide
    
    view.addSubview(winningLabel)

    winningLabel.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
    winningLabel.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor, constant: -30).isActive = true
    
    }
    
}
