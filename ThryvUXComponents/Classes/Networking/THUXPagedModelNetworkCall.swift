//
//  THUXPagedModelNetworkCall.swift
//  ThryvUXComponents
//
//  Created by Elliot Schrock on 8/10/18.
//

import UIKit

open class THUXPagedModelNetworkCall<T>: THUXPagedNetworkCall, THUXJsonDecoder where T: Decodable {
    open lazy var modelSignal = dataSignal.skipNil().map(parseDecodable).skipNil()
    public var decoder: JSONDecoder = THUXJsonProvider.defaultJsonDecoder()
    
    func parseDecodable(json: Data) -> T? {
        do {
            let result = try decoder.decode(T.self, from: json)
            return result
        } catch {
            print("\(error)")
            return nil
        }
    }
}
