//
//  CredsLoginNetworkCall.swift
//  ThryvUXComponents
//
//  Created by Elliot Schrock on 2/10/18.
//

import UIKit
import FunkyNetwork

class CredsLoginNetworkCall: JsonNetworkCall {
    static var usernameKey = "username"
    static var passwordKey = "password"

    init(configuration: ServerConfigurationProtocol, endpoint: String = "sessions", _ username: String, _ password: String, wrapKey: String? = "user", stubHolder: StubHolderProtocol? = nil) {
        var json: [String: Any] = [CredsLoginNetworkCall.usernameKey: username, CredsLoginNetworkCall.passwordKey: password]
        if let key = wrapKey {
            json = [key: json]
        }
        let postData = JsonDataHandler.deserialize(json)
        
        super.init(configuration: configuration, httpMethod: "POST", endpoint: endpoint, postData: postData, stubHolder: stubHolder)
    }
}
