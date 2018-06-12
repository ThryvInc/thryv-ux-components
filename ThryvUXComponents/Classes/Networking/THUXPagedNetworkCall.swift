//
//  THUXPagedNetworkCall.swift
//  ThryvUXComponents
//
//  Created by Elliot Schrock on 2/10/18.
//

import UIKit

open class THUXPagedNetworkCall: THUXUrlParameteredNetworkCall {
    var pageParamName = "page"
    var page: Int = 0

    override open func urlString(_ endpoint: String) -> String {
        if var params = urlParams {
            params[pageParamName] = page
        } else {
            urlParams = [pageParamName: page]
        }
        
        return super.urlString(endpoint)
    }
}
