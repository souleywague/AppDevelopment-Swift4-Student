//
//  ViewController.swift
//  InterfaceBuilderBasics
//
//  Created by Souley on 24/10/2018.
//  Copyright © 2018 Souley. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var mainLabel: UILabel!
    @IBAction func changeTitle(_ sender: Any) {
        if mainLabel.text == "I'm learning to make awesome apps!" {
            mainLabel.text =  "This app rocks!"
        } else { mainLabel.text = "I'm learning to make awesome apps!"}
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

