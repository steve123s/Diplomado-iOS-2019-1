//
//  ViewController.swift
//  LogIn
//
//  Created by Servicio Esteban  on 24/08/18.
//  Copyright © 2018 Servicio Esteban . All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var forgotUserNameButton: UIButton!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    @IBOutlet weak var logInButton: UIButton!
    
    @IBAction func logInButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "Logged", sender: logInButton)
        

    }
    
    @IBAction func forgotUsernameButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "ForgotUsernameOrPassword", sender: forgotUserNameButton)
    }
    
    @IBAction func forgotPasswordButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "ForgotUsernameOrPassword", sender: forgotPasswordButton)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let sender = sender as? UIButton else {return}
        
        if sender == forgotPasswordButton {
            segue.destination.navigationItem.title = "Forgot Password"
        } else if sender == forgotUserNameButton {
            segue.destination.navigationItem.title = "Forgot Username"
        } else {
            segue.destination.navigationItem.title = username.text
        }
    }

}

