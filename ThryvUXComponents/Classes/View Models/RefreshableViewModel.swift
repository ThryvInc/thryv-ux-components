//
//  RefreshableViewModel.swift
//  ThryvUXComponents
//
//  Created by Elliot Schrock on 2/11/18.
//

import UIKit
import ReactiveSwift
import Result

protocol Pageable {
    func refresh()
    func nextPage()
    func fetchPage(_ page: Int)
}

class THUXRefreshableViewModel: Pageable {
    let pageProperty = MutableProperty<Int>(0)
    var call: PagedNetworkCall?
    
    init(_ call: PagedNetworkCall) {
        self.call = call
    }
    
    func viewDidLoad() {
        pageProperty.signal.observeValues { page in
            self.call?.page = page
            self.call?.fire()
        }
    }
    
    func refresh() {
        pageProperty.value = 0
    }
    
    func nextPage() {
        pageProperty.value = pageProperty.value + 1
    }
    
    func fetchPage(_ page: Int) {
        pageProperty.value = page
    }
    
}
