//
//  ViewController.swift
//  IBBasics
//
//  Created by Souley on 24/10/2018.
//  Copyright © 2018 Souley. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBAction func buttonPressed(_ sender: Any) {
        print("The button was pressed")
    }
    @IBOutlet weak var myButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myButton.setTitleColor(.red, for: .normal)
        // Do any additional setup after loading the view, typically from a nib.
    }


}

