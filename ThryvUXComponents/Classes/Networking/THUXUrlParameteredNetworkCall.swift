//
//  THUXUrlParameteredNetworkCall.swift
//  ThryvUXComponents
//
//  Created by Elliot Schrock on 4/30/18.
//

import UIKit
import Prelude

open class THUXUrlParameteredNetworkCall: THUXAuthenticatedNetworkCall {
    public var urlParams: [String: Any]?
    
    override open func urlString(_ endpoint: String) -> String {
        return super.urlString(endpoint) |> addParamsToUrl(_:)
    }
    
    open func addParamsToUrl(_ url: String) -> String {
        if let params = urlParams, params.keys.count > 0 {
            return "\(url)?\(params |> THUXUrlParameteredNetworkCall.pairsToString)"
        }
        return url
    }
    
    open static func pairsToString(_ params: [String: Any]) -> String {
        return params.keys.map({ "\($0)=\(params[$0]!)" }).joined(separator: "&")
    }

}
