//
//  AddToDoViewController.swift
//  ToDoListProgrammatic
//
//  Created by Souley on 12/01/2019.
//  Copyright © 2019 Souley. All rights reserved.
//

import Foundation
import UIKit

protocol SaveToDoDelegate {
    func saveButtonTapped(todo: ToDo)
}

class AddToDoViewController : UIViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: - Properties
    
    private let cellId = "cellId"
    
    var todo: ToDo?
    
    var delegate: SaveToDoDelegate?
    
    private let titleTextField: UITextField = {
        let titleTextField = UITextField()
        
        titleTextField.attributedPlaceholder = NSAttributedString(string: "Remind me to...")
        titleTextField.addTarget(self, action: #selector(textEditingChanged), for: .valueChanged)
        
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        
        return titleTextField
    }()
    
    private let isCompleteButton: UIButton = {
        let isCompleteButton = UIButton()
        
        let checked = UIImage(named: "Checked")
        let unchecked = UIImage(named: "Unchecked")
        
        isCompleteButton.setImage(unchecked, for: .normal)
        isCompleteButton.setImage(checked, for: .selected)
        
        isCompleteButton.translatesAutoresizingMaskIntoConstraints = false
        
        return isCompleteButton
    }()
    
    private lazy var isPickerHidden = true
    
    private let dueDatePickerView: UIDatePicker = {
        let dueDatePickerView = UIDatePicker()
        
        dueDatePickerView.date = Date()
        dueDatePickerView.translatesAutoresizingMaskIntoConstraints = false
        
        return dueDatePickerView
    }()
    
    private let dueDatePickerLabel: UILabel = {
        let dueDatePickerLabel = UILabel()
        
        dueDatePickerLabel.translatesAutoresizingMaskIntoConstraints = false

        return dueDatePickerLabel
    }()
    
    private let dueDateLabel: UILabel = {
        let dueDateLabel = UILabel()
       
        dueDateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        dueDateLabel.text = "Due Date"
        return dueDateLabel
    }()
    
    private let notesTextView: UITextView = {
        let notesTextView = UITextView()
        
        notesTextView.isEditable = true
        notesTextView.textAlignment = .justified
        
        notesTextView.translatesAutoresizingMaskIntoConstraints = false
        
        return notesTextView
    }()
    
    // MARK: - TableView
    
    private lazy var addToDoTableView = UITableView()
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = "New ToDo"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonItemTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonItemTapped))
        
        setupTableView()
        setupActions()
        updateToDo()
        updateDueDatePickerLabel(date: dueDatePickerView.date)
        updateSaveButtonState()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateToDo()
    }
    
    // MARK: - TableView data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        switch indexPath {
        case [0,0]:
            cell.addSubview(isCompleteButton)
            isCompleteButton.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: 10).isActive = true
            isCompleteButton.heightAnchor.constraint(equalToConstant: 36).isActive = true
            isCompleteButton.widthAnchor.constraint(equalToConstant: 36).isActive = true
            isCompleteButton.centerYAnchor.constraint(equalTo: cell.centerYAnchor).isActive = true
            
            cell.addSubview(titleTextField)
            titleTextField.leadingAnchor.constraint(equalTo: isCompleteButton.trailingAnchor, constant: 10).isActive = true
            titleTextField.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: -10).isActive = true
            titleTextField.centerYAnchor.constraint(equalTo: cell.centerYAnchor).isActive = true
        case [1,0]:
            cell.addSubview(dueDateLabel)
            dueDateLabel.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: 20).isActive = true
            dueDateLabel.topAnchor.constraint(equalTo: cell.topAnchor, constant: 10).isActive = true
            
            cell.addSubview(dueDatePickerLabel)
            dueDatePickerLabel.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: -20).isActive = true
            dueDatePickerLabel.topAnchor.constraint(equalTo: cell.topAnchor, constant: 10).isActive = true
            
            cell.addSubview(dueDatePickerView)
            dueDatePickerView.topAnchor.constraint(equalTo: cell.topAnchor, constant: 44).isActive = true
            dueDatePickerView.leadingAnchor.constraint(equalTo: cell.leadingAnchor).isActive = true
            dueDatePickerView.trailingAnchor.constraint(equalTo: cell.trailingAnchor).isActive = true
            dueDatePickerView.bottomAnchor.constraint(equalTo: cell.bottomAnchor).isActive = true
        case [2,0]:
            cell.addSubview(notesTextView)
            notesTextView.topAnchor.constraint(equalTo: cell.topAnchor).isActive = true
            notesTextView.leadingAnchor.constraint(equalTo: cell.leadingAnchor).isActive = true
            notesTextView.trailingAnchor.constraint(equalTo: cell.trailingAnchor).isActive = true
            notesTextView.bottomAnchor.constraint(equalTo: cell.bottomAnchor).isActive = true
        default:
            return cell
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "basic info"
        case 1:
            return "due date"
        case 2:
            return "notes"
        default:
            break
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let normalCellHeight = CGFloat(44)
        let largeCellHeight = CGFloat(200)
        
        switch (indexPath) {
        case [1,0]:
            return isPickerHidden ? normalCellHeight : largeCellHeight
        case [2,0]:
            return largeCellHeight
        default:
            return normalCellHeight
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath {
        case [1,0]:
            isPickerHidden = !isPickerHidden
            
            dueDatePickerLabel.textColor = isPickerHidden ? .black : tableView.tintColor
            
            tableView.beginUpdates()
            tableView.endUpdates()
        default:
            break
        }
    }
    
    // MARK: - Setup functions
    
    private func setupTableView() {
        addToDoTableView = UITableView(frame: view.bounds, style: .grouped)
        
        view.addSubview(addToDoTableView)
        
        addToDoTableView.delegate = self
        addToDoTableView.dataSource = self
        addToDoTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
        addToDoTableView.translatesAutoresizingMaskIntoConstraints = false
        
        addToDoTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        addToDoTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        addToDoTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        addToDoTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func setupActions() {
        titleTextField.addTarget(self, action: #selector(textEditingChanged), for: .editingDidEnd)
        titleTextField.addTarget(self, action: #selector(titleTextFieldReturnPressed), for: .primaryActionTriggered)
        isCompleteButton.addTarget(self, action: #selector(isCompleteButtonTapped), for: .touchUpInside)
        dueDatePickerView.addTarget(self, action: #selector(dueDatePickerViewValueChanged), for: .valueChanged)
    }
    
    private func updateToDo() {
        if let todo = todo {
            navigationItem.title = todo.title
            titleTextField.text = todo.title
            isCompleteButton.isSelected = todo.isComplete
            dueDatePickerView.date = todo.dueDate
            notesTextView.text = todo.notes
        } else {
            navigationItem.title = ""
            titleTextField.text = ""
            isCompleteButton.isSelected = false
            notesTextView.text = ""
            dueDatePickerView.date = Date().addingTimeInterval(24*60*60)
        }
    }
    
    private func updateDueDatePickerLabel(date: Date) {
        dueDatePickerLabel.text = ToDo.dueDateFormatter.string(from: date)
    }
    
    private func updateSaveButtonState() {
        let text = titleTextField.text ?? ""
        navigationItem.rightBarButtonItem?.isEnabled = !text.isEmpty
    }
    
    // MARK: - Actions
    
    @objc private func textEditingChanged() {
        updateSaveButtonState()
    }
    
    @objc private func isCompleteButtonTapped() {
        isCompleteButton.isSelected = !isCompleteButton.isSelected
    }
    
    @objc private func dueDatePickerViewValueChanged() {
        updateDueDatePickerLabel(date: dueDatePickerView.date)
    }
    
    @objc private func cancelButtonItemTapped() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc private func titleTextFieldReturnPressed() {
        titleTextField.resignFirstResponder()
    }
    
    @objc private func saveButtonItemTapped() {
        let title = titleTextField.text!
        let isComplete = isCompleteButton.isSelected
        let dueDate = dueDatePickerView.date
        let notes = notesTextView.text
        let todo = ToDo(title: title, isComplete: isComplete, dueDate: dueDate, notes: notes)
        
        delegate?.saveButtonTapped(todo: todo)
        
        navigationController?.popViewController(animated: true)
    }
    
}
