//
//  THUXModelsCall.swift
//  ThryvUXComponents
//
//  Created by Elliot Schrock on 7/18/18.
//

import UIKit

public protocol THUXJsonDecoder {
    var decoder: JSONDecoder { get set }
}

open class THUXModelCall<T>: THUXAuthenticatedNetworkCall, THUXJsonDecoder where T: Decodable {
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
