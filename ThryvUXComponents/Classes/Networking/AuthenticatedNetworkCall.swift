//
//  AuthenticatedNetworkCall.swift
//  ThryvUXComponents
//
//  Created by Elliot Schrock on 2/10/18.
//

import UIKit
import FunkyNetwork

class AuthenticatedNetworkCall: JsonNetworkCall {
    
    override init(configuration: ServerConfigurationProtocol, httpMethod: String, httpHeaders: Dictionary<String, String>?, endpoint: String, postData: Data?, stubHolder: StubHolderProtocol?) {
        super.init(configuration: configuration, httpMethod: httpMethod, httpHeaders: AuthenticatedNetworkCall.jsonHeaders(httpHeaders), endpoint: endpoint, postData: postData, stubHolder: stubHolder)
    }
    
    open static func jsonHeaders(_ httpHeaders: [String : String]?) -> [String : String]? {
        var headers = httpHeaders ?? super.jsonHeaders()
        if let key = THUXSessionManager.session?.authHeaderKey(), let value = THUXSessionManager.session?.authHeaderValue() {
            headers[key] = value
        }
        return headers
    }

}
