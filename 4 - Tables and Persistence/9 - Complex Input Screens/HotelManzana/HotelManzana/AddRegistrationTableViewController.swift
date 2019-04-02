//
//  AddRegistrationTableViewController.swift
//  HotelManzana
//
//  Created by Souley on 03/01/2019.
//  Copyright © 2019 Souley. All rights reserved.
//

import UIKit

class AddRegistrationTableViewController: UITableViewController, SelectRoomTypeViewControllerDelegate {
    
    let checkInDatePickerCellIndexPath = IndexPath(row: 1, section: 1)
    let checkOutDatePickerCellIndexPath = IndexPath(row: 3, section: 1)
    
    var isCheckInDatePickerShown: Bool = false {
        didSet {
            checkInDatePicker.isHidden = !isCheckInDatePickerShown
        }
    }
    
    var isCheckOutDatePickerShown: Bool = false {
        didSet {
            checkOutDatePicker.isHidden = !isCheckOutDatePickerShown
        }
    }
    
    var roomType: RoomType?
    
    var registration: Registration? {
       
        guard let roomType = roomType else { return nil }
        
        let firstName = firstNameTextField.text ?? ""
        let lastName = lastNameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let checkInDate = checkInDatePicker.date
        let checkOutDate = checkOutDatePicker.date
        let numberOfAdults = numberOfAdultsStepper.value
        let numberOfChildren = numberOfChildrenStepper.value
        let hasWifi = wifiSwitch.isOn
        
        return Registration(firstName: firstName,
                            lastName: lastName,
                            emailAddress: email,
                            checkInDate: checkInDate,
                            checkOutDate: checkOutDate,
                            numberOfAdults: numberOfAdults,
                            numberOfChildren: numberOfChildren,
                            roomType: roomType,
                            wifi: hasWifi)
    }
    
    var selectedItem: Registration?
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var checkInDateLabel: UILabel!
    @IBOutlet weak var checkInDatePicker: UIDatePicker!
    @IBOutlet weak var checkOutDateLabel: UILabel!
    @IBOutlet weak var checkOutDatePicker: UIDatePicker!
    
    @IBOutlet weak var numberOfAdultsLabel: UILabel!
    @IBOutlet weak var numberOfAdultsStepper: UIStepper!
    @IBOutlet weak var numberOfChildrenLabel: UILabel!
    @IBOutlet weak var numberOfChildrenStepper: UIStepper!
    
    @IBOutlet weak var wifiSwitch: UISwitch!
    
    @IBOutlet weak var roomTypeLabel: UILabel!
    
    @IBOutlet weak var numberOfNightsLabel: UILabel!
    @IBOutlet weak var roomTypeChargesLabel: UILabel!
    @IBOutlet weak var wifiChargesLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateSelectedItem()
        updateSummary()
        updateDoneButton()
        
        let midnightToday = Calendar.current.startOfDay(for: Date())
        checkInDatePicker.minimumDate = midnightToday
        checkInDatePicker.date = midnightToday
        
        updateDateViews()
        updateNumberOfGuest()
        updateRoomType()
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch (indexPath.section, indexPath.row) {
        case (checkInDatePickerCellIndexPath.section, checkInDatePickerCellIndexPath.row):
            if isCheckInDatePickerShown {
                return 216.0
            } else {
                return 0.0
            }
        case (checkOutDatePickerCellIndexPath.section, checkOutDatePickerCellIndexPath.row):
            if isCheckOutDatePickerShown {
                return 216.0
            } else {
                return 0.0
            }
        default:
            return 44.0
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch (indexPath.section, indexPath.row) {
        case (checkInDatePickerCellIndexPath.section, checkInDatePickerCellIndexPath.row - 1):
            if isCheckInDatePickerShown {
                isCheckInDatePickerShown = false
            } else if isCheckOutDatePickerShown {
                isCheckOutDatePickerShown = false
                isCheckInDatePickerShown = true
            } else {
                isCheckInDatePickerShown = true
            }
            
            tableView.beginUpdates()
            tableView.endUpdates()
            
        case (checkOutDatePickerCellIndexPath.section, checkOutDatePickerCellIndexPath.row - 1):
            if isCheckOutDatePickerShown {
                isCheckOutDatePickerShown = false
            } else if isCheckInDatePickerShown {
                isCheckInDatePickerShown = false
                isCheckOutDatePickerShown = true
            } else {
                isCheckOutDatePickerShown = true
            }
            
            tableView.beginUpdates()
            tableView.endUpdates()
            
        default:
            break
        }
    }

    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        updateDateViews()
        updateDoneButton()
        updateSummary()
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        updateNumberOfGuest()
        updateDoneButton()
        updateSummary()
    }
    
    @IBAction func wifiSwitchChanged(_ sender: UISwitch) {
        if wifiSwitch.isOn {
            wifiChargesLabel.text = "Yes      $\(10 * (Int(numberOfNightsLabel.text!)!))"
        } else {
            wifiChargesLabel.text = "No Wifi"
        }
        updateDoneButton()
        updateSummary()
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func updateDateViews() {
        checkOutDatePicker.minimumDate = checkInDatePicker.date.addingTimeInterval(86400)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        checkInDateLabel.text = dateFormatter.string(from: checkInDatePicker.date)
        checkOutDateLabel.text = dateFormatter.string(from: checkOutDatePicker.date)
    }
    
    func updateNumberOfGuest() {
        numberOfAdultsLabel.text = "\(Int(numberOfAdultsStepper.value))"
        numberOfChildrenLabel.text = "\(Int(numberOfChildrenStepper.value))"
    }
    
    func updateRoomType() {
        guard let roomType = roomType else {
            return roomTypeLabel.text = "Not Set"
        }
        roomTypeLabel.text = roomType.name
    }
    
    func didSelect(roomType: RoomType) {
        self.roomType = roomType
        updateRoomType()
        updateDoneButton()
        updateSummary()
    }
    
    func updateSelectedItem() {
        guard let selectedItem = selectedItem else { return }
        
        firstNameTextField.text = selectedItem.firstName
        lastNameTextField.text = selectedItem.lastName
        emailTextField.text = selectedItem.emailAddress
        checkInDatePicker.date = selectedItem.checkInDate
        checkOutDatePicker.date = selectedItem.checkOutDate
        numberOfAdultsStepper.value = selectedItem.numberOfChildren
        numberOfChildrenStepper.value = selectedItem.numberOfAdults
        wifiSwitch.isOn = selectedItem.wifi
        roomType = selectedItem.roomType
    }
    
    func updateDoneButton() {
        if self.registration != nil && firstNameTextField.text?.isEmpty == false && lastNameTextField.text?.isEmpty == false && emailTextField.text?.isEmpty == false {
            return doneButton.isEnabled = true
        } else {
            doneButton.isEnabled = false
        }
    }
    
    func updateSummary() {
        guard let _ = numberOfNightsLabel, let roomType = roomType else { return }
        
        let numberOfNights = DateInterval(start: checkInDatePicker.date, end: checkOutDatePicker.date)
        numberOfNightsLabel.text = String(numberOfNights.duration)
        
        roomTypeChargesLabel.text = "\(String(describing: roomType.shortName))     $\(String(describing: roomType.price))"
        
        let total = Int(numberOfNights.duration) * roomType.price
        
        totalLabel.text = "$ \(total) - wifi not included"
        tableView.reloadData()
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SelectRoomType" {
            let destinationViewController = segue.destination as? SelectRoomTypeTableViewController
            destinationViewController?.delegate = self
            destinationViewController?.roomType = roomType
        }
    }
}
