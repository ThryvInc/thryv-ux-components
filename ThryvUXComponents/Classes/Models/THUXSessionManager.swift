//
//  THUXSessionManager.swift
//  ThryvUXComponents
//
//  Created by Elliot Schrock on 2/10/18.
//

import UIKit

@objc public protocol THUXSession {
    @objc optional func authHeaders() -> [String: String]?
    @objc optional var authHeaderKey: String? { get }
    @objc optional var authHeaderValue: String? { get }
    
    func isAuthenticated() -> Bool
}

open class THUXSessionManager: NSObject {
    public static var session: THUXSession?
}

open class THUXUserDefaultsSession: THUXSession {
    public let authDefaultsKey: String
    public let authHeaderKey: String?
    
    public init(authDefaultsKey: String, authHeaderKey: String) {
        self.authDefaultsKey = authDefaultsKey
        self.authHeaderKey = authHeaderKey
    }
    
    open func authHeaders() -> [String: String]? {
        if let headerKey = authHeaderKey {
            return [headerKey: UserDefaults.standard.string(forKey: authDefaultsKey) ?? ""]
        }
        return nil
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
