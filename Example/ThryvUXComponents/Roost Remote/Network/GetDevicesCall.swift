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

class GetDevicesCall: THUXPagedNetworkCall {
    lazy var devicesSignal = dataSignal.skipNil().map(parseJsonDevices).skipNil()

    init(placeId: String, stubHolder: StubHolderProtocol? = nil) {
        super.init(configuration: RRServerConfiguration.current, httpMethod: "GET", httpHeaders: [:], endpoint: "places/\(placeId)/devices", postData: nil, stubHolder: stubHolder)
    }
}

func parseJsonDevices(json: Data) -> [Device]? {
    do {
        let decoder = JSONDecoder()
        let result = try decoder.decode([Device].self, from: json)
        return result
    } catch {
        print("\(error)")
        return nil
    }
}
