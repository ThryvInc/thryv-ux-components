//
//  THUXAuthenticatedNetworkCall.swift
//  ThryvUXComponents
//
//  Created by Elliot Schrock on 2/10/18.
//

import UIKit
import FunkyNetwork
import Prelude

open class THUXAuthenticatedNetworkCall: JsonNetworkCall {
    
    public override init(configuration: ServerConfigurationProtocol, httpMethod: String, httpHeaders: Dictionary<String, String>?, endpoint: String, postData: Data?, networkErrorHandler: NetworkErrorHandler? = nil, stubHolder: StubHolderProtocol?) {
        super.init(configuration: configuration, httpMethod: httpMethod, httpHeaders: httpHeaders |> type(of: self).addAuthHeader, endpoint: endpoint, postData: postData, networkErrorHandler: networkErrorHandler, stubHolder: stubHolder)
    }
    
    public static func authHeaders() -> [String : String] {
        if let keyVal = THUXSessionManager.session?.authHeaders?() {
            return keyVal
        } else if let headerKey = THUXSessionManager.session?.authHeaderKey as? String, let headerValue = THUXSessionManager.session?.authHeaderValue as? String {
            return [headerKey: headerValue]
        }
        return [:]
    }
    
    open class func addAuthHeader(_ httpHeaders: [String: String]?) -> [String: String] {
        let authHeader = authHeaders()
        if var headers = httpHeaders {
            for key in authHeader.keys {
                headers[key] = authHeader[key]
            }
            return headers
        }
        return authHeader
    }

}
