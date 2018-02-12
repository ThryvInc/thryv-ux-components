//
//  LoginViewModel.swift
//  ThryvUXComponents
//
//  Created by Elliot Schrock on 2/11/18.
//

import UIKit
import ReactiveSwift
import Result

protocol LoginInputs {
    func usernameChanged(username: String?)
    func passwordChanged(password: String?)
    func submitButtonPressed()
    func viewDidLoad()
}

protocol LoginOutputs {
    var submitButtonEnabled: Signal<Bool, NoError> { get }
}

protocol LoginProtocol {
    var inputs: LoginInputs { get }
    var outputs: LoginOutputs { get }
}

class THUXLoginViewModel: LoginProtocol, LoginInputs, LoginOutputs {
    var inputs: LoginInputs { return self }
    var outputs: LoginOutputs { return self }
    
    let usernameChangedProperty = MutableProperty<String?>(nil)
    let passwordChangedProperty = MutableProperty<String?>(nil)
    let submitButtonPressedProperty = MutableProperty(())
    let viewDidLoadProperty = MutableProperty(())
    
    let submitButtonEnabled: Signal<Bool, NoError>
    
    let successfulCredEntry: Signal<(String?, String?), NoError>
    let submittedFormDataInvalid: Signal<(String?, String?), NoError>

    init() {
        let formData = Signal.combineLatest(
            self.usernameChangedProperty.signal,
            self.passwordChangedProperty.signal
        )
        
        successfulCredEntry = formData
            .sample(on: self.submitButtonPressedProperty.signal)
            .filter(THUXLoginViewModel.isValidCreds(username:password:))
        
        submittedFormDataInvalid = formData
            .sample(on: self.submitButtonPressedProperty.signal)
            .filter { !THUXLoginViewModel.isValidCreds(username: $0, password: $1) }
        
        submitButtonEnabled = Signal.merge(
            self.viewDidLoadProperty.signal.map { _ in false },
            formData.map(THUXLoginViewModel.isCredsPresent(username:password:))
        )
    }
    
    func usernameChanged(username: String?) {
        self.usernameChangedProperty.value = username
    }
    
    func passwordChanged(password: String?) {
        self.passwordChangedProperty.value = password
    }
    
    func submitButtonPressed() {
        self.submitButtonPressedProperty.value = ()
    }
    
    func viewDidLoad() {
        self.viewDidLoadProperty.value = ()
    }
    
    static func isValidCreds(username: String?, password: String?) -> Bool {
        return false
    }
    
    static func isCredsPresent(username: String?, password: String?) -> Bool {
        return false
    }
}
