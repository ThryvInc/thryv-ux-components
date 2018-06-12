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

class RRDeviceViewModel: NSObject {
    let dataSource = MultiModelTableViewDataSource()
    let call: THUXPagedNetworkCall
    let deviceItemSignal: Signal<[MultiModelTableViewDataSourceSection], NoError>
    
    init(placeId: String) {
        let transform = RRDeviceViewModel.deviceItemsFromDevices
            >>> MultiModelTableViewDataSourceSection.itemsToSection
            >>> arrayOfSingleObject
        
        let devicesCall = GetDevicesCall(placeId: placeId)
        self.call = devicesCall
        
        self.deviceItemSignal = devicesCall.devicesSignal.map(transform)

        super.init()

        self.deviceItemSignal.observeValues {
            self.dataSource.sections = $0
            self.dataSource.tableView?.reloadData()
        }
    }
    
    static func deviceItemsFromDevices(devices: [Device]) -> [DeviceItem] {
        return devices.map(DeviceItem.item)
    }
}
