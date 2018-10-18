//
//  THUXTokenLoginNetworkCall.swift
//  ThryvUXComponents
//
//  Created by Elliot Schrock on 9/2/18.
//

import UIKit
import FunkyNetwork

open class THUXTokenLoginNetworkCall: JsonNetworkCall {
    open var wrapKey: String?
    open var tokenKey = "facebook_token"
    open var token: String!
    
    init(configuration: ServerConfigurationProtocol, endpoint: String, _ wrapKey: String? = "user", networkErrorHandler: NetworkErrorHandler? = nil, stubHolder: StubHolderProtocol? = nil) {
        super.init(configuration: configuration, httpMethod: "POST", endpoint: endpoint, postData: nil, networkErrorHandler: networkErrorHandler, stubHolder: stubHolder)
    }
    
    open override func applyBody(_ request: NSURLRequest?) -> NSMutableURLRequest {
        var json: [String: Any] = [tokenKey: token]
        if let key = wrapKey {
            json = [key: json]
        }
        let postData = JsonDataHandler.deserialize(json)
        
        let mutableRequest = request?.mutableCopy() as! NSMutableURLRequest
        mutableRequest.httpBody = postData
        return mutableRequest
    }

}
