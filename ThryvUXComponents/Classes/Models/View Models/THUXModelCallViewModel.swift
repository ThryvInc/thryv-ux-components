//
//  THUXModelCallViewModel.swift
//  ThryvUXComponents
//
//  Created by Elliot Schrock on 7/23/18.
//

import UIKit
import MultiModelTableViewDataSource
import Prelude
import Result
import ReactiveSwift

open class THUXModelCallViewModel<T>: NSObject {
    public let modelsSignal: Signal<[T], NoError>
    
    public init(modelsSignal: Signal<[T], NoError>) {
        self.modelsSignal = modelsSignal
        
        super.init()
    }
}
