//
//  ViewController.swift
//  LightApp
//
//  Created by Souley on 25/10/2018.
//  Copyright © 2018 Souley. All rights reserved.
//

import UIKit

var lightOn = true

class ViewController: UIViewController {
    @IBAction func buttonPressed(_ sender: Any) {
        lightOn = !lightOn
        updateUI()
    }
    
    func updateUI() {
        view.backgroundColor = lightOn ? .white : .black
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        // Do any additional setup after loading the view, typically from a nib.
    }
}

