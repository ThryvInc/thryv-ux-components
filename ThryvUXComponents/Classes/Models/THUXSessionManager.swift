//
//  THUXSessionManager.swift
//  ThryvUXComponents
//
//  Created by Elliot Schrock on 2/10/18.
//

import UIKit

public protocol THUXSession {
    func authHeaderKey() -> String
    func authHeaderValue() -> String
    
    func isAuthenticated() -> Bool
}

open class THUXSessionManager: NSObject {
    public static var session: THUXSession?
}

open class THUXUserDefaultsSession: THUXSession {
    open let authDefaultsKey: String
    open let authHeaderKeyString: String
    
    public init(authDefaultsKey: String, authHeaderKey: String) {
        self.authDefaultsKey = authDefaultsKey
        self.authHeaderKeyString = authHeaderKey
    }
    
    open func authHeaderKey() -> String {
        return authHeaderKeyString
    }
    
    open func authHeaderValue() -> String {
        return UserDefaults.standard.string(forKey: authDefaultsKey) ?? ""
    }
    
    open func setAuthValue(authString: String) {
        UserDefaults.standard.set(authString, forKey: authDefaultsKey)
        UserDefaults.standard.synchronize()
    }
    
    open func isAuthenticated() -> Bool {
        let apiKey = UserDefaults.standard.string(forKey: authDefaultsKey)
        return apiKey != nil && apiKey != ""
    }
}
