//
//  THUXFBLoginNetworkCall.swift
//  ThryvUXComponents
//
//  Created by Elliot Schrock on 2/10/18.
//

import UIKit
import FunkyNetwork

open class THUXFBLoginNetworkCall: JsonNetworkCall {
    open var wrapKey: String?
    open var tokenKey = "facebook_token"
    open var facebookToken: String!
    
    init(configuration: ServerConfigurationProtocol, endpoint: String, _ wrapKey: String? = "user", stubHolder: StubHolderProtocol? = nil) {
        super.init(configuration: configuration, httpMethod: "POST", endpoint: endpoint, postData: nil, stubHolder: stubHolder)
    }
    
    open override func applyBody(_ request: NSURLRequest) -> NSMutableURLRequest {
        var json: [String: Any] = [tokenKey: facebookToken]
        if let key = wrapKey {
            json = [key: json]
        }
        let postData = JsonDataHandler.deserialize(json)
        
        let mutableRequest = request.mutableCopy() as! NSMutableURLRequest
        mutableRequest.httpBody = postData
        return mutableRequest
    }
}
