//
//  ViewController.swift
//  LightApp 3.0
//
//  Created by Souley on 28/10/2018.
//  Copyright © 2018 Souley. All rights reserved.
//

import UIKit

var lightOn = false

class ViewController: UIViewController {
    @IBOutlet weak var labelText: UILabel!
    
    @IBAction func buttonPressed(_ sender: Any) {
        lightOn = !lightOn
        updateLight()
    }
    
    func updateLight() {
        view.backgroundColor = lightOn ? .black : .white
        labelText.text = lightOn ? "SWITCH BITCH!" : "IT'S SWITCHED BITCH"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateLight()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

