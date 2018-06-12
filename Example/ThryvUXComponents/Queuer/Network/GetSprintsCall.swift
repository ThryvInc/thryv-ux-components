//
//  GetSprintsCall.swift
//  ThryvUXComponents_Example
//
//  Created by Elliot Schrock on 6/9/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import ThryvUXComponents
import FunkyNetwork
import Result
import ReactiveSwift

class GetSprintsCall: THUXPagedNetworkCall {
    public lazy var sprintsSignal: Signal<[Sprint], NoError> = self.dataSignal.skipNil().map(GetSprintsCall.parse).skipNil()
    
    init(stubHolder: StubHolderProtocol? = nil) {
        super.init(configuration: QERServerConfiguration.current, httpMethod: "GET", httpHeaders: [:], endpoint: "sprints", postData: nil, stubHolder: stubHolder)
    }
    
    static func parse(json: Data) -> [Sprint]? {
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
            let result = try decoder.decode([Sprint].self, from: json)
            return result
        } catch {
            print("\(error)")
            return nil
        }
    }
}

extension DateFormatter {
    static let iso8601Full: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
}
