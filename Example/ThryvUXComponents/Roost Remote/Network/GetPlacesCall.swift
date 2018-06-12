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

class GetPlacesCall: THUXPagedNetworkCall {
    lazy var placesSignal = dataSignal.skipNil().map(parseJsonPlaces).skipNil()
    
    init(stubHolder: StubHolderProtocol? = nil) {
        super.init(configuration: RRServerConfiguration.current, httpMethod: "GET", httpHeaders: [:], endpoint: "places", postData: nil, stubHolder: stubHolder)
    }
}

func parseJsonPlaces(json: Data) -> [Place]? {
    do {
        let decoder = JSONDecoder()
        let result = try decoder.decode([Place].self, from: json)
        return result
    } catch {
        print("\(error)")
        return nil
    }
}
