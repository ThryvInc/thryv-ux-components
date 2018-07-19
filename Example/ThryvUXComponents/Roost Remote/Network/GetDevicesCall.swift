//
//  GetDevicesCall.swift
//  ThryvUXComponents_Example
//
//  Created by Elliot Schrock on 6/12/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import ThryvUXComponents
import FunkyNetwork

class GetDevicesCall: THUXModelCall<[Device]> {
    lazy var devicesSignal = modelSignal
    
    init(placeId: String, stubHolder: StubHolderProtocol? = nil) {
        super.init(configuration: RRServerConfiguration.current, httpMethod: "GET", httpHeaders: [:], endpoint: "places/\(placeId)/devices", postData: nil, stubHolder: stubHolder)
    }
}
