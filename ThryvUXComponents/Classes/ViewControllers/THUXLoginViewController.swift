//
//  THUXLoginViewController.swift
//  ThryvUXComponents
//
//  Created by Elliot Schrock on 2/10/18.
//

import UIKit
import FBSDKLoginKit

open class THUXLoginViewController: UIViewController, FBSDKLoginButtonDelegate {
    @IBOutlet open weak var logoImageView: UIImageView?
    @IBOutlet open weak var usernameTextField: UITextField?
    @IBOutlet open weak var passwordTextField: UITextField?
    @IBOutlet open weak var loginButton: UIButton?
    @IBOutlet open weak var signUpButton: UIButton?
    @IBOutlet open weak var fbLoginButton: FBSDKLoginButton?
    @IBOutlet open weak var orLabel: UILabel?
    @IBOutlet open weak var spinner: UIActivityIndicatorView?
    
    open var loginViewModel: THUXLoginProtocol?
    
    override open func viewDidLoad() {
        super.viewDidLoad()

        loginViewModel?.outputs.submitButtonEnabled.observeValues({ enabled in
            self.loginButton?.isEnabled = enabled
        })
        loginViewModel?.outputs.activityIndicatorVisible.observeValues({ (visible) in
            self.spinner?.isHidden = !visible
        })
        fbLoginButton?.delegate = self
        loginViewModel?.inputs.viewDidLoad()
    }
    
    @IBAction open func usernameChanged() {
        loginViewModel?.inputs.usernameChanged(username: usernameTextField!.text)
    }
    
    @IBAction open func passwordChanged() {
        loginViewModel?.inputs.passwordChanged(password: passwordTextField!.text)
    }
    
    @IBAction open func loginButtonPressed() {
        loginViewModel?.inputs.submitButtonPressed()
    }
    
    @IBAction open func signUpPressed() {
        
    }
    
    open func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        loginViewModel?.inputs.facebookLoggedIn(token: result.token)
    }
    
    open func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {}
}
