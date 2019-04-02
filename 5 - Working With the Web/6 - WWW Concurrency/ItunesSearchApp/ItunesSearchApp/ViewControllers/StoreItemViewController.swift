//
//  StoreItemViewController.swift
//  ItunesSearchApp
//
//  Created by Souley on 23/01/2019.
//  Copyright © 2019 Souley. All rights reserved.
//

import UIKit

class StoreItemViewController: UIViewController {
    
    // MARK: - User Interface
    
    let filterSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Music", "Movies", "Apps", "Books"])
        
        segmentedControl.selectedSegmentIndex = 0
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        return segmentedControl
    }()
    
    let iTunesSearchTableView: UITableView = {
        let tableView = UITableView()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    let iTunesSearchBarItem: UISearchBar = {
        let searchBar = UISearchBar()
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        return searchBar
    }()
    
    // MARK: - Properties
    
    let storeItemController = StoreItemController()
    
    let cellID = "cellID"
    
    var items = [StoreItem]()
    
    let queryOptions = ["music", "movie", "software", "ebook"]
    
    // MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        navigationItem.titleView = filterSegmentedControl
        
        setupLayout()
        setupActions()
    }
}

// MARK: - Protocols

extension StoreItemViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: cellID)
        
        configure(cell: cell, forItemAt: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Functions

extension StoreItemViewController {
    
    func fetchMatchingItems() {
        self.items = []
        self.iTunesSearchTableView.reloadData()
        
        let searchTerm = iTunesSearchBarItem.text ?? ""
        let mediaType = queryOptions[filterSegmentedControl.selectedSegmentIndex]
        
        if !searchTerm.isEmpty {
            let query: [String: String] = [
                "term": searchTerm,
                "media": mediaType,
                "lang": "en_us",
                "limit": "20"
            ]
            storeItemController.fetchItems(matching: query) { (storeItem) in
                if let storeItem = storeItem {
                    DispatchQueue.main.async {
                        self.items = storeItem
                        self.iTunesSearchTableView.reloadData()
                    }
                }
            }
        }
    }
    
    func configure(cell: UITableViewCell, forItemAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = item.artist
        cell.imageView?.image = UIImage(named: "gray")
        
        let task = URLSession.shared.dataTask(with: item.artworkURL) { (data, response, error) in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    cell.imageView?.image = image
                }
            }
        }
        task.resume()
    }
}

// MARK: - Delegates

extension StoreItemViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        fetchMatchingItems()
        searchBar.resignFirstResponder()
    }
}

// MARK: - Setup Functions

extension StoreItemViewController {
    func setupLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        view.addSubview(iTunesSearchTableView)
        view.addSubview(iTunesSearchBarItem)
        
        iTunesSearchTableView.delegate = self
        iTunesSearchTableView.dataSource = self
        iTunesSearchTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        
        iTunesSearchBarItem.delegate = self
        
        iTunesSearchBarItem.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        iTunesSearchBarItem.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        iTunesSearchBarItem.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
        iTunesSearchBarItem.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        iTunesSearchTableView.topAnchor.constraint(equalTo: iTunesSearchBarItem.bottomAnchor).isActive = true
        iTunesSearchTableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        iTunesSearchTableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
        iTunesSearchTableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
    }
    
    func setupActions() {
        iTunesSearchBarItem.target(forAction: #selector(searchBarSearchButtonClicked), withSender: self)
    }
}
