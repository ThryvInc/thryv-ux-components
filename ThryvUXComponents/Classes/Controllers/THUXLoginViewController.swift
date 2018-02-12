//
//  THUXLoginViewController.swift
//  ThryvUXComponents
//
//  Created by Elliot Schrock on 2/10/18.
//

import UIKit
import FBSDKLoginKit

class THUXLoginViewController: UIViewController {
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var fbLoginButton: FBSDKLoginButton!
    @IBOutlet weak var orLabel: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var loginViewModel: LoginProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loginViewModel?.outputs.submitButtonEnabled.observeValues({ enabled in
            self.loginButton.isEnabled = enabled
        })
        loginViewModel?.inputs.viewDidLoad()
    }
    
    @IBAction func usernameChanged() {
        loginViewModel?.inputs.usernameChanged(username: usernameTextField.text)
    }
    
    @IBAction func passwordChanged() {
        loginViewModel?.inputs.passwordChanged(password: passwordTextField.text)
    }
    
    @IBAction func loginButtonPressed() {
        loginViewModel?.inputs.submitButtonPressed()
    }
    
    @IBAction func signUpPressed() {
        
    }
}
