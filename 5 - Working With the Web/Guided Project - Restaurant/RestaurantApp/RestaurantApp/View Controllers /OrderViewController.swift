//
//  YourOrderViewController.swift
//  RestaurantApp
//
//  Created by Souley on 27/01/2019.
//  Copyright © 2019 Souley. All rights reserved.
//

import UIKit

class OrderViewController: UIViewController {
    
    // MARK: - User Interface
    
    let orderTableView: UITableView = {
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
    
    let orderCellID = "orderCellID"
    
    var menuItems = [MenuItem]()
    
    var orderMinutes: Int!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Submit", style: UIBarButtonItem.Style.plain, target: self, action: #selector(submitButtonTapped))
        
        setupTableView()
        updateSubmitButtonState()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateSubmitButtonState()
    }
    
    // MARK: - Actions
    
    @objc func submitButtonTapped() {
        let orderTotal = menuItems.reduce(0.0) { $0 + $1.price }
        let formattedOrder = String(format: "$%.2f", orderTotal)
        
        let alert = UIAlertController(title: "Confirm Order", message: "You are about to submit your order with a total of \(formattedOrder)", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Submit", style: .default, handler: { (action) in
            self.uploadOrder()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    @objc func uploadOrder() {
        let menuIds = menuItems.map { $0.id }
        MenuController.shared.submitOrder(menuIds: menuIds) { (minutes) in
            DispatchQueue.main.async {
                if let minutes = minutes {
                    self.orderMinutes = minutes
                    let orderConfirmationViewController = OrderConfirmationViewController()
                    orderConfirmationViewController.minutes = self.orderMinutes
                    self.navigationController?.show(orderConfirmationViewController, sender: self)
                }
            }
        }
    }
}

// MARK: - TableView Protocols and Data Source

extension OrderViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: orderCellID)
        
        configure(cell: cell, forItemAt: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(!isEditing, animated: true)
        orderTableView.setEditing(!orderTableView.isEditing, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            menuItems.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            updateBadgeNumber()
            updateSubmitButtonState()
        }
    }
}

// MARK: - Setup Functions

extension OrderViewController {
    func setupTableView() {
        let safeArea = view.safeAreaLayoutGuide
        
        view.addSubview(orderTableView)
        
        orderTableView.delegate = self
        orderTableView.dataSource = self
        orderTableView.register(UITableViewCell.self, forCellReuseIdentifier: orderCellID)
        
        orderTableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        orderTableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        orderTableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
        orderTableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
    }
    
    func configure(cell: UITableViewCell, forItemAt indexPath: IndexPath) {
        let menuItem = menuItems[indexPath.row]
        cell.textLabel?.text = menuItem.name
        cell.detailTextLabel?.text = String(format: "$%.2f", menuItem.price)
        MenuController.shared.fetchImage(url: menuItem.imageURL) { (image) in
            guard let image = image else { return }
            DispatchQueue.main.async {
                if let currentIndexPath = self.orderTableView.indexPath(for: cell), currentIndexPath != indexPath {
                    return
                }
                cell.imageView?.image = image
                cell.setNeedsLayout()
            }
        }
    }
    
    func updateBadgeNumber() {
        let badgeValue = menuItems.count > 0 ? "\(menuItems.count)" : nil
        navigationController?.tabBarItem.badgeValue = badgeValue
    }
    
    func updateSubmitButtonState() {
        navigationItem.rightBarButtonItem?.isEnabled = !menuItems.isEmpty
    }
}

// MARK: - Protocols

extension OrderViewController: AddToOrderDelegate {
    func added(menuItem: MenuItem) {
        menuItems.append(menuItem)
        let count = menuItems.count
        let indexPath = IndexPath(row: count - 1, section: 0)
        orderTableView.insertRows(at: [indexPath], with: .automatic)
        updateBadgeNumber()
    }
}

extension OrderViewController: OrderConfirmationDelegate {
    func didTapDismissButton() {
        menuItems.removeAll()
        orderTableView.reloadData()
        updateBadgeNumber()
    }
}
