//
//  MenuItemViewController.swift
//  RestaurantApp
//
//  Created by Souley on 27/01/2019.
//  Copyright © 2019 Souley. All rights reserved.
//

import UIKit

class MenuItemDetailViewController: UIViewController {
    
    // MARK: - User Interface
    
    let itemImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let uiLabel = UILabel()
        
        uiLabel.font = .systemFont(ofSize: 20, weight: UIFont.Weight(rawValue: 600))
        uiLabel.minimumScaleFactor = 0.5
        uiLabel.textAlignment = .natural
        uiLabel.text = "Title Label"
        
        uiLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return uiLabel
    }()
    
    let priceLabel: UILabel = {
        let uiLabel = UILabel()
        
        uiLabel.font.withSize(18)
        uiLabel.textAlignment = .right
        uiLabel.text = "Price"
        
        uiLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return uiLabel
    }()
    
    let descriptionLabel: UILabel = {
        let uiLabel = UILabel()
        
        uiLabel.font.withSize(18)
        uiLabel.textAlignment = .natural
        uiLabel.textColor = .lightGray
        uiLabel.numberOfLines = 0
        uiLabel.text = "Description"
        
        uiLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return uiLabel
    }()
    
    let addToOrderButton: UIButton = {
        let uiButton = UIButton()
        
        uiButton.setTitleColor(.white, for: .normal)
        uiButton.backgroundColor = .blue
        uiButton.alpha = 0.7
        uiButton.layer.cornerRadius = 5.0
        uiButton.clipsToBounds = true
        uiButton.setTitle("Add To Order", for: .normal)
        
        uiButton.translatesAutoresizingMaskIntoConstraints = false
        
        return uiButton
    }()
    
    // MARK: - Properties
    
    var menuItem: MenuItem!
    
    var delegate: AddToOrderDelegate?
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = menuItem.name
        
        setupLayout()
        setupActions()
        updateUI()
        setupDelegate()
    }
    
    // MARK: - Actions
    
    @objc func addToOrderButtonTapped() {
        UIView.animate(withDuration: 0.5, animations: {
            self.addToOrderButton.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
            self.addToOrderButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }) { (_) in
            self.addToOrderButton.transform = .identity
        }
        delegate?.added(menuItem: menuItem)
    }
}

// MARK: - Setup Functions

extension MenuItemDetailViewController {
    func setupLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        view.addSubview(itemImageView)
        view.addSubview(titleLabel)
        view.addSubview(priceLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(addToOrderButton)
        
        itemImageView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 10).isActive = true
        itemImageView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10).isActive = true
        itemImageView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10).isActive = true
        itemImageView.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 0.25).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: itemImageView.bottomAnchor, constant: 8).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: priceLabel.leadingAnchor, constant: -8).isActive = true
        
        priceLabel.topAnchor.constraint(equalTo: itemImageView.bottomAnchor, constant: 8).isActive = true
        priceLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10).isActive = true
        priceLabel.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10).isActive = true
        
        addToOrderButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -20).isActive = true
        addToOrderButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10).isActive = true
        addToOrderButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10).isActive = true
    }
    
    func setupActions() {
        addToOrderButton.addTarget(self, action: #selector(addToOrderButtonTapped), for: .touchUpInside)
    }
    
    func updateUI() {
        titleLabel.text = menuItem.name
        priceLabel.text = String(format: "$%.2f", menuItem.price)
        descriptionLabel.text = menuItem.description
        MenuController.shared.fetchImage(url: menuItem.imageURL) { (image) in
            guard let image = image else { return }
            DispatchQueue.main.async {
                self.itemImageView.image = image
            }
        }
    }
    
    func setupDelegate() {
        if let navigationController = tabBarController?.viewControllers?.last as? UINavigationController, let orderViewController = navigationController.viewControllers.first as? OrderViewController {
            delegate = orderViewController
        }
    }
}
