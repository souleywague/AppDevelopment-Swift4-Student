//
//  ViewController.swift
//  TrafficSegues
//
//  Created by Souley on 06/12/2018.
//  Copyright © 2018 Souley. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var segueSwitch: UISwitch!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func orangeButtonTapped(_ sender: Any) {
        if segueSwitch.isOn {
            performSegue(withIdentifier: "Orange", sender: nil)
        }
    }
    
    @IBAction func greenButtonTapped(_ sender: Any) {
        if segueSwitch.isOn {
            performSegue(withIdentifier: "Green", sender: nil)
        }
    }
}

