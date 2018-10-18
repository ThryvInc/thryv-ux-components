//
//  THUXPagedNetworkCall.swift
//  ThryvUXComponents
//
//  Created by Elliot Schrock on 2/10/18.
//

import FunkyNetwork

open class THUXPagedNetworkCall: THUXUrlParameteredNetworkCall {
    var pageParamName = "page"
    var page: Int = 0
    
    public override init(configuration: ServerConfigurationProtocol, httpMethod: String, httpHeaders: Dictionary<String, String>?, endpoint: String, postData: Data?, networkErrorHandler: NetworkErrorHandler?, stubHolder: StubHolderProtocol?) {
        super.init(configuration: configuration, httpMethod: httpMethod, httpHeaders: httpHeaders, endpoint: endpoint, postData: postData, networkErrorHandler: networkErrorHandler, stubHolder: stubHolder)
        
        let superUrlString = urlString
        urlString = { endpoint in
            if var params = self.urlParams {
                params[self.pageParamName] = self.page
            } else {
                self.urlParams = [self.pageParamName: self.page]
            }
            
            return superUrlString(endpoint)
        }
    }
}
