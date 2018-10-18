//
//  THUXUrlParameteredNetworkCall.swift
//  ThryvUXComponents
//
//  Created by Elliot Schrock on 4/30/18.
//

import UIKit
import FunkyNetwork
import Prelude

open class THUXUrlParameteredNetworkCall: THUXAuthenticatedNetworkCall {
    public var urlParams: [String: Any]?
    
    public override init(configuration: ServerConfigurationProtocol, httpMethod: String, httpHeaders: Dictionary<String, String>?, endpoint: String, postData: Data?, networkErrorHandler: NetworkErrorHandler?, stubHolder: StubHolderProtocol?) {
        super.init(configuration: configuration, httpMethod: httpMethod, httpHeaders: httpHeaders, endpoint: endpoint, postData: postData, networkErrorHandler: networkErrorHandler, stubHolder: stubHolder)
        
        let superUrlString = urlString
        urlString = { endpoint in
            return endpoint |> superUrlString |> self.addParamsToUrl
        }
    }
    
    open func addParamsToUrl(_ url: String) -> String {
        if let params = urlParams, params.keys.count > 0 {
            return "\(url)?\(params |> THUXUrlParameteredNetworkCall.pairsToString)"
        }
        return url
    }
    
    public static func pairsToString(_ params: [String: Any]) -> String {
        return params.keys.map({ "\($0)=\(params[$0]!)" }).joined(separator: "&")
    }

}
