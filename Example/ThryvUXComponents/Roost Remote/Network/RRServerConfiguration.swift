//
//  RRServerConfiguration.swift
//  ThryvUXComponents_Example
//
//  Created by Elliot Schrock on 6/11/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import FunkyNetwork

class RRServerConfiguration: ServerConfiguration {
    public static let production = ServerConfiguration(scheme: "https", host: "roost-remote-devices.herokuapp.com", apiRoute: "api/v1")
    public static let stub = ServerConfiguration(shouldStub: true, scheme: "https", host: "roost-remote-devices.herokuapp.com", apiRoute: "api/v1")
    
    public static let current = production
}
