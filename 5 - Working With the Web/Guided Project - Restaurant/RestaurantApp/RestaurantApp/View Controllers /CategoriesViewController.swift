//
//  CategoriesViewController.swift
//  RestaurantApp
//
//  Created by Souley on 27/01/2019.
//  Copyright © 2019 Souley. All rights reserved.
//

import UIKit

class CategoriesViewController: UIViewController {

    // MARK: - User Interface
    
    let categoriesTableView: UITableView = {
        let tableView = UITableView()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    // MARK: - Properties
    
    let categoriesCellID = "categoriesCellID"
    
    var categories = [String]()
    
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = "Menu"
        
        setupTableView()
        
        MenuController.shared.fetchCategories { (categories) in
            if let categories = categories {
                self.updateUI(with: categories)
            }
        }
    }
}

// MARK: - TableView Protocols

extension CategoriesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: categoriesCellID, for: indexPath)
        
        cell.accessoryType = .disclosureIndicator
        
        configure(cell: cell, forItemAt: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedIndexPath = tableView.indexPathForSelectedRow!
        let selectedCategory = categories[selectedIndexPath.row]
        
        let menuViewController = MenuViewController()
        menuViewController.category = selectedCategory
        tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.show(menuViewController, sender: self)
    }
    
}

// MARK: - Setup Functions

extension CategoriesViewController {
    func setupTableView() {
        let safeArea = view.safeAreaLayoutGuide
        
        view.addSubview(categoriesTableView)
        
        categoriesTableView.delegate = self
        categoriesTableView.dataSource = self
        categoriesTableView.register(UITableViewCell.self, forCellReuseIdentifier: categoriesCellID)
        
        categoriesTableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        categoriesTableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        categoriesTableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
        categoriesTableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
    }
    
    func updateUI(with categories: [String]) {
        DispatchQueue.main.async {
            self.categories = categories
            self.categoriesTableView.reloadData()
        }
    }
    
    func configure(cell: UITableViewCell, forItemAt indexPath: IndexPath) {
        let categoryString = categories[indexPath.row]
        cell.textLabel?.text = categoryString.capitalized
    }
    
}
