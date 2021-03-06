//
//  THUXVersionChecker.swift
//  ThryvUXComponents
//
//  Created by Elliot Schrock on 2/10/18.
//

import UIKit

public protocol THUXVersionChecker {
    func isCurrentVersion(appVersion: String, completion: (Bool) -> Void)
    func appVersionString() -> String
}
