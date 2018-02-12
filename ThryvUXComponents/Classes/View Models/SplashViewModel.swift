//
//  SplashViewModel.swift
//  ThryvUXComponents
//
//  Created by Elliot Schrock on 2/11/18.
//

import UIKit
import ReactiveSwift
import Result

protocol SplashTask {
    func execute(completion: () -> Void)
}

protocol SplashInputs {
    func viewDidLoad()
    func viewWillAppear()
    func viewDidAppear()
}

protocol SplashOutputs {
    var performAnimationsSignal: Signal<(), NoError> { get }
    var advanceUnauthedSignal: Signal<(), NoError> { get }
    var advanceAuthedSignal: Signal<(), NoError> { get }
    var displayableViewControllerSignal: Signal<UIViewController, NoError> { get }
}

protocol SplashProtocol {
    var inputs: SplashInputs { get }
    var outputs: SplashOutputs { get }
}

class THUXSplashViewModel: SplashInputs, SplashOutputs, SplashProtocol {
    var inputs: SplashInputs { return self }
    var outputs: SplashOutputs { return self }
    
    let performAnimationsSignal: Signal<(), NoError>
    let performAnimationsProperty = MutableProperty(())
    
    let advanceAuthedSignal: Signal<(), NoError>
    let advanceAuthedProperty = MutableProperty(())

    let advanceUnauthedSignal: Signal<(), NoError>
    let advanceUnauthedProperty = MutableProperty(())
    
    let displayableViewControllerSignal: Signal<UIViewController, NoError>
    let displayableViewControllerProperty = MutableProperty<UIViewController?>(nil)
    
    let viewDidLoadProperty = MutableProperty(())
    let viewWillAppearProperty = MutableProperty(())
    let viewDidAppearProperty = MutableProperty(())
    
    let isAuthedProperty = MutableProperty<Bool>(false)
    
    let semaphoreProperty = MutableProperty<Int>(0)
    
    init(minimumVisibleTime: Double?, _ versionChecker: THUXVersionChecker?, _ session: THUXSession?, _ otherTasks: [SplashTask]?) {
        performAnimationsSignal = performAnimationsProperty.signal
        advanceAuthedSignal = advanceAuthedProperty.signal
        advanceUnauthedSignal = advanceUnauthedProperty.signal
        displayableViewControllerSignal = displayableViewControllerProperty.signal.skipNil()
        
        var semaphore = 0
        
        semaphore += 1                                  // view must appear
        semaphore += otherTasks?.count ?? 0             // other tasks to be executed
        semaphore += versionChecker == nil ? 0 : 1      // check version
        semaphore += session == nil ? 0 : 1             // check session
        
        viewDidLoadProperty.signal.observeValues { _ in
            versionChecker?.isCurrentVersion(appVersion: versionChecker?.appVersionString() ?? "0.0.0", completion: { isCurrent in
                if isCurrent {
                    self.semaphoreProperty.value -= 1
                } else {
                    self.displayableViewControllerProperty.value = self.versionUpdatePrompt()
                }
            })
            
            if let tasks = otherTasks {
                for task in tasks {
                    task.execute {
                        self.semaphoreProperty.value -= 1
                    }
                }
            }
            
            self.isAuthedProperty.value = session?.isAuthenticated() ?? false
        }
        
        viewDidAppearProperty.signal.observeValues { _ in
            self.semaphoreProperty.value -= 1
            
            self.performAnimationsProperty.value = ()
        }
        
        if let minTime = minimumVisibleTime {
            semaphore += 1
            viewWillAppearProperty.signal.observeValues({ _ in
                DispatchQueue.main.asyncAfter(deadline: (.now() + minTime)) {
                    self.semaphoreProperty.value -= 1
                }
            })
        }
        
        semaphoreProperty.value = semaphore
        
        semaphoreProperty.signal.observeValues { value in
            if value == 0 {
                if self.isAuthedProperty.value {
                    self.advanceAuthedProperty.value = ()
                } else {
                    self.advanceUnauthedProperty.value = ()
                }
            }
        }
    }
    
    func versionUpdatePrompt() -> UIViewController {
        //override me!
        return UIViewController()
    }
    
    // MARK: - Inputs
    
    func viewDidLoad() {
        viewDidLoadProperty.value = ()
    }
    
    func viewWillAppear() {
        viewWillAppearProperty.value = ()
    }
    
    func viewDidAppear() {
        viewDidAppearProperty.value = ()
    }
}
