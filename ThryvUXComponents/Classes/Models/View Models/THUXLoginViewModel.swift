//
//  THUXLoginViewModel.swift
//  ThryvUXComponents
//
//  Created by Elliot Schrock on 2/11/18.
//

import UIKit
import ReactiveSwift
import Result
import FBSDKLoginKit

public protocol THUXLoginInputs {
    func usernameChanged(username: String?)
    func passwordChanged(password: String?)
    func submitButtonPressed()
    func facebookLoggedIn(token: FBSDKAccessToken)
    func viewDidLoad()
}

public protocol THUXLoginOutputs {
    var submitButtonEnabled: Signal<Bool, NoError> { get }
    var activityIndicatorVisible: Signal<Bool, NoError> { get }
    var advanceAuthed: Signal<(), NoError> { get }
}

public protocol THUXLoginProtocol {
    var inputs: THUXLoginInputs { get }
    var outputs: THUXLoginOutputs { get }
}

open class THUXLoginViewModel: THUXLoginProtocol, THUXLoginInputs, THUXLoginOutputs {
    open var inputs: THUXLoginInputs { return self }
    open var outputs: THUXLoginOutputs { return self }
    
    let usernameChangedProperty = MutableProperty<String?>(nil)
    let passwordChangedProperty = MutableProperty<String?>(nil)
    let submitButtonPressedProperty = MutableProperty(())
    let viewDidLoadProperty = MutableProperty(())
    
    public let submitButtonEnabled: Signal<Bool, NoError>
    
    public let activityIndicatorVisible: Signal<Bool, NoError>
    let activityIndicatorVisibleProperty = MutableProperty<Bool>(false)
    
    public let advanceAuthed: Signal<(), NoError>
    let advanceAuthedProperty = MutableProperty(())
    
    public let successfulCredEntry: Signal<(String?, String?), NoError>
    public let submittedFormDataInvalid: Signal<(String?, String?), NoError>
    
    let fbTokenProperty = MutableProperty<String?>(nil)
    
    public let credentialLoginCall: THUXCredsLoginNetworkCall?
    public let fbTokenLoginCall: THUXTokenLoginNetworkCall?

    public init(credsCall: THUXCredsLoginNetworkCall? = nil, fbCall: THUXTokenLoginNetworkCall? = nil) {
        credentialLoginCall = credsCall
        fbTokenLoginCall = fbCall
        
        advanceAuthed = advanceAuthedProperty.signal
        
        activityIndicatorVisible = activityIndicatorVisibleProperty.signal
        
        let formData = Signal.combineLatest(
            self.usernameChangedProperty.signal,
            self.passwordChangedProperty.signal
        )
        
        successfulCredEntry = formData
            .sample(on: self.submitButtonPressedProperty.signal)
            .filter(type(of: self).isValidCreds(username:password:))
        
        submittedFormDataInvalid = formData
            .sample(on: self.submitButtonPressedProperty.signal)
            .filter(type(of: self).isInvalidCreds(username:password:))
        
        submitButtonEnabled = Signal.merge(
            self.viewDidLoadProperty.signal.map { _ in false },
            formData.map(type(of: self).isCredsPresent(username:password:)),
            self.activityIndicatorVisibleProperty.signal.map { visible in !visible}
        )
        
        submitButtonPressedProperty.signal.observeValues { _ in
            self.credentialLoginCall?.username = self.usernameChangedProperty.value
            self.credentialLoginCall?.password = self.passwordChangedProperty.value
            self.credentialLoginCall?.fire()
            self.activityIndicatorVisibleProperty.value = true
        }
        
        fbTokenProperty.signal.skipNil().observeValues { (token) in
            self.fbTokenLoginCall?.token = token
            self.fbTokenLoginCall?.fire()
            self.activityIndicatorVisibleProperty.value = true
        }
        
        fbTokenLoginCall?.httpResponseSignal.observeValues(authResponseReceived)
        
        credentialLoginCall?.httpResponseSignal.observeValues(authResponseReceived)
    }
    
    open func usernameChanged(username: String?) {
        self.usernameChangedProperty.value = username
    }
    
    open func passwordChanged(password: String?) {
        self.passwordChangedProperty.value = password
    }
    
    open func submitButtonPressed() {
        self.submitButtonPressedProperty.value = ()
    }
    
    open func facebookLoggedIn(token: FBSDKAccessToken) {
        fbTokenProperty.value = token.tokenString
    }
    
    open func viewDidLoad() {
        self.viewDidLoadProperty.value = ()
    }
    
    open func authResponseReceived(response: HTTPURLResponse) {
        if response.statusCode < 300 {
            self.advanceAuthedProperty.value = ()
        }
        self.activityIndicatorVisibleProperty.value = false
    }
    
    open static func isValidCreds(username: String?, password: String?) -> Bool {
        return true
    }
    
    open static func isInvalidCreds(username: String?, password: String?) -> Bool {
        return false
    }
    
    open static func isCredsPresent(username: String?, password: String?) -> Bool {
        return username != nil && !(username!.isEmpty) && password != nil && !(password!.isEmpty)
    }
}
