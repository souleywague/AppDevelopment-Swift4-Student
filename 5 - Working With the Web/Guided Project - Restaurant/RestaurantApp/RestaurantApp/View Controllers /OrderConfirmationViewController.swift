//
//  OrderConfirmationViewController.swift
//  RestaurantApp
//
//  Created by Souley on 27/01/2019.
//  Copyright © 2019 Souley. All rights reserved.
//

import UIKit

class OrderConfirmationViewController: UIViewController {
    
    // MARK: - User Interface
    
    let timeRemainingLabel: UILabel = {
        let uiLabel = UILabel()
        
        uiLabel.font.withSize(18)
        uiLabel.textAlignment = .center
        uiLabel.text = "Time remaining"
        uiLabel.numberOfLines = 0
        
        uiLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return uiLabel
    }()
    
    let dismissButton: UIButton = {
        let uiButton = UIButton()
        
        uiButton.setTitleColor(.white, for: .normal)
        uiButton.backgroundColor = .blue
        uiButton.alpha = 0.7
        uiButton.layer.cornerRadius = 5.0
        uiButton.clipsToBounds = true
        uiButton.setTitle("Dismiss", for: .normal)
        
        uiButton.translatesAutoresizingMaskIntoConstraints = false
        
        return uiButton
    }()
    
    // MARK: - Properties 
    
    var minutes: Int!
    let rootViewController = OrderViewController()
    var delegate: OrderConfirmationDelegate?
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        setupActions()
        updateUI()
        setupDelegate()
    }
    
    // MARK: - Actions
    
    @objc func dismissButtonTapped() {
        UIView.animate(withDuration: 0.5, animations: {
            self.dismissButton.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
            self.dismissButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }) { (_) in
            self.dismissButton.transform = .identity
        }
        
        delegate?.didTapDismissButton()
        
        navigationController?.popToRootViewController(animated: true)
    }

}
// MARK: - Setup Functions 

extension OrderConfirmationViewController {
    func setupLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        view.addSubview(timeRemainingLabel)
        view.addSubview(dismissButton)
        
        timeRemainingLabel.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor).isActive = true
        timeRemainingLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10).isActive = true
        timeRemainingLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10).isActive = true
        
        dismissButton.topAnchor.constraint(equalTo: timeRemainingLabel.bottomAnchor, constant: 15).isActive = true
        dismissButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10).isActive = true
        dismissButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10).isActive = true 
    }
    
    func setupActions() {
        dismissButton.addTarget(self, action: #selector(dismissButtonTapped), for: .touchUpInside)
    }
    
    func updateUI() {
        timeRemainingLabel.text = "Thank you for your order! Your wait time is approximately \(minutes!) minutes."
    }
    
    func setupDelegate() {
        if let navigationController = tabBarController?.viewControllers?.last as? UINavigationController, let orderViewController = navigationController.viewControllers.first as? OrderViewController {
            delegate = orderViewController
        }
    }
    
}
