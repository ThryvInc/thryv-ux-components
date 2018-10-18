//
//  CredsLoginNetworkCall.swift
//  ThryvUXComponents
//
//  Created by Elliot Schrock on 2/10/18.
//

import UIKit
import FunkyNetwork

open class THUXCredsLoginNetworkCall: JsonNetworkCall {
    open var usernameKey = "username"
    open var passwordKey = "password"
    open var wrapKey: String?
    
    open var username: String!
    open var password: String!
    
    public init(configuration: ServerConfigurationProtocol, endpoint: String = "sessions", wrapKey: String? = "user", networkErrorHandler: NetworkErrorHandler? = nil, stubHolder: StubHolderProtocol? = nil) {
        super.init(configuration: configuration, httpMethod: "POST", endpoint: endpoint, postData: nil, networkErrorHandler: networkErrorHandler, stubHolder: stubHolder)
    }
    
    open override func applyBody(_ request: NSURLRequest?) -> NSMutableURLRequest {
        var json: [String: Any] = [usernameKey: username, passwordKey: password]
        if let key = wrapKey {
            json = [key: json]
        }
        let postData = JsonDataHandler.deserialize(json)
        
        let mutableRequest = request?.mutableCopy() as! NSMutableURLRequest
        mutableRequest.httpBody = postData
        return mutableRequest
    }
}
