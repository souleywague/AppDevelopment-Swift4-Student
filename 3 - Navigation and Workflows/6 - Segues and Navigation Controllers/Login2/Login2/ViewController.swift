//
//  ViewController.swift
//  Login2
//
//  Created by Souley on 08/12/2018.
//  Copyright © 2018 Souley. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    struct User {
        var login: String
        var password: String
    }
    
    var mimi = User(login: "Mimi Lolipop", password: "Mimi666")
    
    
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButtonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func loginButton(_ sender: UIButton) {
        guard userNameField.text == mimi.login && passwordField.text == mimi.password else {
            performSegue(withIdentifier: "SecondPage", sender: self)
            return
        }
        performSegue(withIdentifier: "SecondPage", sender: self)
    }
    
    @IBAction func unwindToWelcomePage(unwindSegue: UIStoryboardSegue) {
        
    }
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard userNameField.text == mimi.login && passwordField.text == mimi.password else {
            segue.destination.navigationItem.title = "Password Forgotten?"
            return
        }
        segue.destination.navigationItem.title = userNameField.text
    }
}

