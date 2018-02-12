//
//  THUXSessionManager.swift
//  ThryvUXComponents
//
//  Created by Elliot Schrock on 2/10/18.
//

import UIKit

protocol THUXSession {
    func authHeaderKey() -> String
    func authHeaderValue() -> String
    
    func isAuthenticated() -> Bool
}

class THUXSessionManager: NSObject {
    public static var session: THUXSession?
}
