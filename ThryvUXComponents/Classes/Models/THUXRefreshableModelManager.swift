//
//  THUXRefreshableModelManager.swift
//  ThryvUXComponents
//
//  Created by Elliot Schrock on 2/11/18.
//

import UIKit
import ReactiveSwift
import Result

public protocol Pageable {
    func refresh()
    func nextPage()
    func fetchPage(_ page: Int)
}

open class THUXRefreshableModelManager: Pageable {
    open let pageProperty = MutableProperty<Int>(0)
    open var call: THUXPagedNetworkCall?
    
    public init(_ call: THUXPagedNetworkCall) {
        self.call = call
    }
    
    open func viewDidLoad() {
        pageProperty.signal.observeValues { page in
            self.call?.page = page
            self.call?.fire()
        }
    }
    
    open func refresh() {
        pageProperty.value = 0
    }
    
    open func nextPage() {
        pageProperty.value = pageProperty.value + 1
    }
    
    open func fetchPage(_ page: Int) {
        pageProperty.value = page
    }
    
}
