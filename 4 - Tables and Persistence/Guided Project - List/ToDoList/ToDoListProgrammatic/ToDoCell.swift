//
//  ToDoCell.swift
//  ToDoListProgrammatic
//
//  Created by Souley on 10/01/2019.
//  Copyright © 2019 Souley. All rights reserved.
//

import Foundation
import UIKit

protocol ToDoCellDelegate {
    func checkmarkTapped(sender: ToDoCell)
}

class ToDoCell: UITableViewCell {
   
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCellLayout()
        setupCellActions()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Properties
    
    var delegate: ToDoCellDelegate?
    
    private let cellView: UIView = {
        let cellView = UIView()
        
        cellView.translatesAutoresizingMaskIntoConstraints = false
        
        return cellView
    }()
    
    let isCompleteButton: UIButton = {
        let isCompleteButton = UIButton()
        
        let checked = UIImage(named: "Checked")
        let unchecked = UIImage(named: "Unchecked")
        
        isCompleteButton.setImage(unchecked, for: .normal)
        isCompleteButton.setImage(checked, for: .selected)
        
        isCompleteButton.translatesAutoresizingMaskIntoConstraints = false
        
        return isCompleteButton
    }()
    
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return titleLabel
    }()
    
    // MARK: - Actions
    
    @objc private func completeButtonTapped() {
        delegate?.checkmarkTapped(sender: self)
    }
    
    // MARK: - Setup functions
    
    private func setupCellLayout() {
        contentView.addSubview(cellView)
        cellView.addSubview(isCompleteButton)
        cellView.addSubview(titleLabel)
        
        cellView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        cellView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        isCompleteButton.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 10).isActive = true
        isCompleteButton.heightAnchor.constraint(equalToConstant: 36).isActive = true
        isCompleteButton.widthAnchor.constraint(equalToConstant: 36).isActive = true
        isCompleteButton.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: cellView.topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: isCompleteButton.trailingAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -10).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true
    }
    
    private func setupCellActions() {
        isCompleteButton.addTarget(self, action: #selector(completeButtonTapped), for: .touchUpInside)
    }
    
}
