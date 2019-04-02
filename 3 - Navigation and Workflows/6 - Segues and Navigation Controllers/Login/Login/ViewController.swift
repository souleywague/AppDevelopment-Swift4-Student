//
//  ViewController.swift
//  Login
//
//  Created by Souley on 06/12/2018.
//  Copyright © 2018 Souley. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var userNameEntryTextField: UITextField!
    @IBOutlet weak var forgotUserNameButton: UIButton!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func forgotUserNameButton(_ sender: UIButton) {
        performSegue(withIdentifier: "landingRed", sender: forgotUserNameButton)
    }
    
    @IBAction func forgotUserPasswordButton(_ sender: UIButton) {
        performSegue(withIdentifier: "landingRed", sender: forgotPasswordButton)
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        performSegue(withIdentifier: "landingRed", sender: loginButton)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let sender = sender as? UIButton else {return}
        
        if sender == forgotPasswordButton {
            segue.destination.navigationItem.title = "Forgot Passeword"
        } else if sender == forgotUserNameButton {
            segue.destination.navigationItem.title = "Forgot Username"
        } else {
            segue.destination.navigationItem.title = userNameEntryTextField.text
        }
    }
    
    @IBAction func unwindToLogin(unwindSegue: UIStoryboardSegue) {
    }
    
}

