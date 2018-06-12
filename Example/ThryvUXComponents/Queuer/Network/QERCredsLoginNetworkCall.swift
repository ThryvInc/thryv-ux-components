//
//  QERCredsLoginNetworkCall.swift
//  ThryvUXComponents_Example
//
//  Created by Elliot Schrock on 6/9/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import ThryvUXComponents
import FunkyNetwork

class QERCredsLoginNetworkCall: THUXCredsLoginNetworkCall {
    lazy var authResponseSignal = self.dataSignal.skipNil().map(QERCredsLoginNetworkCall.parse).skipNil()

    public init(configuration: ServerConfigurationProtocol = QERServerConfiguration.current, stubHolder: StubHolderProtocol? = nil) {
        super.init(configuration: configuration, endpoint: "session", wrapKey: nil, stubHolder: stubHolder)
        
        authResponseSignal.observeValues { (authResponse) in
            let session = THUXUserDefaultsSession(authDefaultsKey: "qerApiKey", authHeaderKey: "X-Qer-Authorization")
            session.setAuthValue(authString: authResponse.apiKey)
            THUXSessionManager.session = session
        }
    }
    
    static func parse(jsonData: Data) -> QERAuthResponse? {
        do {
            return try JSONDecoder().decode(QERAuthResponse.self, from: jsonData)
        } catch {
            return nil
        }
    }
}
