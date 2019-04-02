//
//  ViewController.swift
//  Two Buttons
//
//  Created by Souley on 25/11/2018.
//  Copyright © 2018 Souley. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func setText(_ sender: UIButton) {
        textLabel.text = textField.text
    }
    
    @IBAction func clearText(_ sender: UIButton) {
        textLabel.text = nil
        textField.text = nil
    }
}

