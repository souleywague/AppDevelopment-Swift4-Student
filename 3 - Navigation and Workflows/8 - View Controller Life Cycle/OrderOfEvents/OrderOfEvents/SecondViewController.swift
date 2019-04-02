//
//  SecondViewController.swift
//  OrderOfEvents
//
//  Created by Souley on 10/12/2018.
//  Copyright © 2018 Souley. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var lifeCycleStatusLabel: UILabel!
    var eventNumber: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let existingText = lifeCycleStatusLabel.text {
            lifeCycleStatusLabel.text = "\(existingText) \nEvent number \(eventNumber) was viewDidload"
            eventNumber += 1
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let existingText = lifeCycleStatusLabel.text {
            lifeCycleStatusLabel.text = "\(existingText) \nEvent number \(eventNumber) was viewWillAppear"
            eventNumber += 1
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let existingText = lifeCycleStatusLabel.text {
            lifeCycleStatusLabel.text = "\(existingText) \nEvent number \(eventNumber) was viewDidAppear"
            eventNumber += 1
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let existingText = lifeCycleStatusLabel.text {
            lifeCycleStatusLabel.text = "\(existingText) \nEvent number \(eventNumber) was viewWillDisappear"
            eventNumber += 1
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if let existingText = lifeCycleStatusLabel.text {
            lifeCycleStatusLabel.text = "\(existingText) \nEvent number \(eventNumber) was viewDidDisappear"
            eventNumber += 1
        }
    }
}
