//
//  RegistrationTableViewController.swift
//  HotelManzana
//
//  Created by Souley on 04/01/2019.
//  Copyright © 2019 Souley. All rights reserved.
//

import UIKit

class RegistrationTableViewController: UITableViewController {

    var registrations: [Registration] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return registrations.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RegistrationCell", for: indexPath)
        
        let registration = registrations[indexPath.row]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        
        cell.textLabel?.text = registration.firstName + " " + registration.lastName
        cell.detailTextLabel?.text = dateFormatter.string(from: registration.checkInDate) + " - " + dateFormatter.string(from: registration.checkOutDate) + ": " + registration.roomType.name

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        
        if segue.identifier == "ShowRegistrationDetails" {
            let destinationViewController = segue.destination as? AddRegistrationTableViewController
            destinationViewController?.selectedItem = registrations[indexPath.row]
        }
    }
    
    @IBAction func unwindFromAddRegistration(unwindSegue: UIStoryboardSegue) {
        if let addRegistrationTableViewController = unwindSegue.source as? AddRegistrationTableViewController, let selectedItem = addRegistrationTableViewController.selectedItem {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                registrations[selectedIndexPath.row] = selectedItem
                tableView.reloadRows(at: [selectedIndexPath], with: .automatic)
            } else {
                let newIndexPath = IndexPath(row: registrations.count, section: 0)
                registrations.append(selectedItem)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
                }
            }
        tableView.reloadData()
    }
}
