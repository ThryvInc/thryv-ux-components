//
//  RRAppOpenFlowController.swift
//  ThryvUXComponents_Example
//
//  Created by Elliot Schrock on 6/11/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import ThryvUXComponents
import MultiModelTableViewDataSource
import Prelude

class RRAppOpenFlowController: THUXAppOpenFlowController {
    private var placesCall: GetPlacesCall?
    
    override init() {
        super.init()
        setupSplash()
        setupLogin()
    }
    
    func setupSplash() {
        THUXSessionManager.session = THUXUserDefaultsSession(authDefaultsKey: "rrApiKey", authHeaderKey: "X-API-Key")
        splashViewModel = THUXSplashViewModel(minimumVisibleTime: 0.0, otherTasks: nil)
    }
    
    func setupLogin() {
        let call = THUXCredsLoginNetworkCall(configuration: RRServerConfiguration.current,
                                             endpoint: "session",
                                             wrapKey: nil,
                                             stubHolder: nil)
        
        call.dataSignal
            .skipNil()
            .map(RRAppOpenFlowController.parseAuthResponse)
            .skipNil()
            .observeValues(RRAppOpenFlowController.createSession)
        
        loginViewModel = THUXLoginViewModel(credsCall: call)
    }
    
    func configureLogin(viewController: RRLoginViewController) {
        viewController.flowController = self
        viewController.loginViewModel = loginViewModel
    }
    
    func configureMain(viewController: RRMainViewController) {
        placesCall = GetPlacesCall()
        placesCall?.placesSignal.observeValues { (places) in
            if let placeId = places.first?._id {
                viewController.viewModel = RRDeviceViewModel(placeId: placeId)
            }
        }
        placesCall?.fire()
    }
    
    static func parseAuthResponse(jsonData: Data) -> RRAuthResponse? {
        do {
            return try JSONDecoder().decode(RRAuthResponse.self, from: jsonData)
        } catch {
            return nil
        }
    }
    
    static func createSession(auth: RRAuthResponse) {
        if let apiKey = auth.apiKey {
            let session = THUXUserDefaultsSession(authDefaultsKey: "rrApiKey", authHeaderKey: "X-API-Key")
            session.setAuthValue(authString: apiKey)
            THUXSessionManager.session = session
        }
    }
}
