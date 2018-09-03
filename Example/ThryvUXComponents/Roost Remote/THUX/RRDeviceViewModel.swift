//
//  RRDeviceViewModel.swift
//  ThryvUXComponents_Example
//
//  Created by Elliot Schrock on 6/11/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import ThryvUXComponents
import MultiModelTableViewDataSource
import Prelude
import Result
import ReactiveSwift

class RRDeviceViewModel: THUXModelListViewModel<Device> {
    let call: THUXModelCall<[Device]>
    
    init(placeId: String) {
        let devicesCall = GetDevicesCall(placeId: placeId)
        self.call = devicesCall

        super.init(modelsSignal: devicesCall.devicesSignal, modelToItem: DeviceItem.item)
    }
}
