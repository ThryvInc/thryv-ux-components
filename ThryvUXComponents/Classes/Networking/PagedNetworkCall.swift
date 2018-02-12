//
//  PagedNetworkCall.swift
//  ThryvUXComponents
//
//  Created by Elliot Schrock on 2/10/18.
//

import UIKit

class PagedNetworkCall: AuthenticatedNetworkCall {
    var page: Int = 0
    
    override func urlString(_ endpoint: String) -> String {
        var url = super.urlString(endpoint)
        url = "\(url)?page=\(page)"
        return url
    }

}
