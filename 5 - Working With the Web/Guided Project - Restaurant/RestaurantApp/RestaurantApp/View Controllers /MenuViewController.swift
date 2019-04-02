//
//  MenuViewController.swift
//  RestaurantApp
//
//  Created by Souley on 27/01/2019.
//  Copyright © 2019 Souley. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    // MARK: - User Interface
    
    let menuTableView: UITableView = {
        let tableView = UITableView()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    let itemImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(named: "placeholder")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    // MARK: - Properties
    
    let menuCellID = "menuCellID"
    
    var menuItems = [MenuItem]()
    
    var category: String!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = category.capitalized
        
        setupTableView()
        
        MenuController.shared.fetchMenuItems(categoryName: category) { (menuItems) in
            if let menuItems = menuItems {
                self.updateUI(with: menuItems)
            }
        }
    }
    
}

// MARK: - TableView Protocols

extension MenuViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: menuCellID)
        
        cell.accessoryType = .disclosureIndicator
        
        cell.imageView?.sizeToFit()
        
        configure(cell: cell, forItemAt: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedIndexPath = tableView.indexPathForSelectedRow!
        let selectedItem = menuItems[selectedIndexPath.row]
        
        let menuItemDetailViewController = MenuItemDetailViewController()
        menuItemDetailViewController.menuItem = selectedItem
        tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.show(menuItemDetailViewController, sender: self)
    }
}

// MARK: - Setup Functions

extension MenuViewController {
    func setupTableView() {
        let safeArea = view.safeAreaLayoutGuide
        
        view.addSubview(menuTableView)
        
        menuTableView.delegate = self
        menuTableView.dataSource = self
        menuTableView.register(UITableViewCell.self, forCellReuseIdentifier: menuCellID)
        
        menuTableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        menuTableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        menuTableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
        menuTableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
    }
    
    func updateUI(with menuItems: [MenuItem]) {
        DispatchQueue.main.async {
            self.menuItems = menuItems
            self.menuTableView.reloadData()
        }
    }
    
    func configure(cell: UITableViewCell, forItemAt indexPath: IndexPath) {
        let menuItem = menuItems[indexPath.row]
        cell.textLabel?.text = menuItem.name
        cell.detailTextLabel?.text = String(format: "$%.2f", menuItem.price)
        MenuController.shared.fetchImage(url: menuItem.imageURL) { (image) in
            guard let image = image else { return }
            DispatchQueue.main.async {
                if let currentIndexPath = self.menuTableView.indexPath(for: cell), currentIndexPath != indexPath {
                    return
                }
                cell.imageView?.image = image
                cell.setNeedsLayout()
            }
        }
    }
    
}
