//
//  HomeViewController.swift
//  ToDoListProgrammatic
//
//  Created by Souley on 10/01/2019.
//  Copyright © 2019 Souley. All rights reserved.
//

import Foundation
import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ToDoCellDelegate, SaveToDoDelegate {
    
    // MARK: - Properties
    
    private let cellId = "cellId"
    
    lazy var todos = [ToDo]()
    
    var todo: ToDo?
    
    // MARK: - TableView
    
   private let todoTableView: UITableView = {
        let todoTableView = UITableView()
        todoTableView.backgroundColor = .white
        
        todoTableView.translatesAutoresizingMaskIntoConstraints = false
        
        return todoTableView
    }()
    
    lazy var addToDoViewController = AddToDoViewController()
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addToDoViewController.delegate = self
        
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = "ToDo"
        
        navigationItem.leftBarButtonItem = editButtonItem
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonTapped))
        
        setupTableView()
        setupToDo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        todoTableView.reloadData()
    }
    
    
    // MARK: - TableView Data sources
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ToDoCell
        cell.delegate = self
        
        let todo = todos[indexPath.row]
        
        cell.titleLabel.text = todo.title
        cell.isCompleteButton.isSelected = todo.isComplete
        
        return cell
    }
    
    // MARK: - TableView delegates
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedIndexPath = tableView.indexPathForSelectedRow!
        let selectedTodo = todos[selectedIndexPath.row]
        todo = selectedTodo
        
        addToDoViewController.todo = todo
        navigationController?.show(addToDoViewController, sender: self)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            todos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            ToDo.saveTodos(todos)
        }
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(!isEditing, animated: true)
        todoTableView.setEditing(!todoTableView.isEditing, animated: true)
    }
    
    // MARK: - Other delegates methods
    
    func checkmarkTapped(sender: ToDoCell) {
        if let indexPath = todoTableView.indexPath(for: sender) {
            var todo = todos[indexPath.row]
            todo.isComplete = !todo.isComplete
            todos[indexPath.row] = todo
            todoTableView.reloadRows(at: [indexPath], with: .automatic)
            ToDo.saveTodos(todos)
        }
    }
    
    func saveButtonTapped(todo: ToDo) {
        if let selectedIndexPath = todoTableView.indexPathForSelectedRow {
            todos[selectedIndexPath.row] = todo
            todoTableView.reloadRows(at: [selectedIndexPath], with: .none)
        } else {
            let newIndexPath = IndexPath(row: todos.count, section: 0)
            todos.append(todo)
            todoTableView.insertRows(at: [newIndexPath], with: .automatic)
        }
        ToDo.saveTodos(todos)
    }
    
    // MARK: - Functions
    
    private func setupTableView() {
        view.addSubview(todoTableView)
        
        todoTableView.delegate = self
        todoTableView.dataSource = self
        todoTableView.register(ToDoCell.self, forCellReuseIdentifier: cellId)
        
        todoTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        todoTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        todoTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        todoTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func setupToDo() {
        if let savedToDos = ToDo.loadToDos() {
            todos = savedToDos
        } else {
            todos = ToDo.loadSampleToDos()
        }
    }
    
    // MARK: - Actions
    
    @objc func addButtonTapped() {
        addToDoViewController.todo = nil
        navigationController?.show(addToDoViewController, sender: self)
    }
    
}
