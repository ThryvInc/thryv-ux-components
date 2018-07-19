//
//  GetPlacesCall.swift
//  ThryvUXComponents_Example
//
//  Created by Elliot Schrock on 6/12/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import ThryvUXComponents
import FunkyNetwork

class GetPlacesCall: THUXModelCall<[Place]> {
    lazy var placesSignal = modelSignal
    
    init(stubHolder: StubHolderProtocol? = nil) {
        super.init(configuration: RRServerConfiguration.current, httpMethod: "GET", httpHeaders: [:], endpoint: "places", postData: nil, stubHolder: stubHolder)
    }
}
