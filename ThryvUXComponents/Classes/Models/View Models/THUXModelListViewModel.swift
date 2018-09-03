//
//  THUXModelListViewModel.swift
//  ThryvUXComponents
//
//  Created by Elliot Schrock on 7/18/18.
//

import UIKit
import MultiModelTableViewDataSource
import Prelude
import Result
import ReactiveSwift

open class THUXModelListViewModel<T>: THUXModelTableViewModel<T> {
    public let dataSource = MultiModelTableViewDataSource()
    
    public override init(modelsSignal: Signal<[T], NoError>, modelToItem: @escaping (T) -> MultiModelTableViewDataSourceItem) {
        super.init(modelsSignal: modelsSignal, modelToItem: modelToItem)
        
        self.sectionsSignal.observeValues {
            self.dataSource.sections = $0
            self.dataSource.tableView?.reloadData()
        }
    }
}
