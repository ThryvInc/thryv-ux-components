//
//  SplashViewModel.swift
//  ThryvUXComponents
//
//  Created by Elliot Schrock on 2/11/18.
//

import UIKit
import ReactiveSwift
import Result

public protocol THUXSplashTask {
    func execute(completion: @escaping () -> Void)
}

public protocol THUXSplashInputs {
    func viewDidLoad()
    func viewWillAppear()
    func viewDidAppear()
}

public protocol THUXSplashOutputs {
    var performAnimationsSignal: Signal<(), NoError> { get }
    var advanceUnauthedSignal: Signal<(), NoError> { get }
    var advanceAuthedSignal: Signal<(), NoError> { get }
    var displayableViewControllerSignal: Signal<UIViewController, NoError> { get }
}

public protocol THUXSplashProtocol {
    var inputs: THUXSplashInputs { get }
    var outputs: THUXSplashOutputs { get }
}

open class THUXSplashViewModel: THUXSplashInputs, THUXSplashOutputs, THUXSplashProtocol {
    public var inputs: THUXSplashInputs { return self }
    public var outputs: THUXSplashOutputs { return self }
    
    public let performAnimationsSignal: Signal<(), NoError>
    public let performAnimationsProperty = MutableProperty(())
    
    public let advanceAuthedSignal: Signal<(), NoError>
    public let advanceAuthedProperty = MutableProperty(())

    public let advanceUnauthedSignal: Signal<(), NoError>
    public let advanceUnauthedProperty = MutableProperty(())
    
    public let displayableViewControllerSignal: Signal<UIViewController, NoError>
    public let displayableViewControllerProperty = MutableProperty<UIViewController?>(nil)
    
    public let viewDidLoadProperty = MutableProperty(())
    public let viewWillAppearProperty = MutableProperty(())
    public let viewDidAppearProperty = MutableProperty(())
    
    public let isAuthedProperty = MutableProperty<Bool>(false)
    
    public let semaphoreProperty = MutableProperty<Int>(0)
    
    public init(minimumVisibleTime: Double?, _ versionChecker: THUXVersionChecker? = nil, _ session: THUXSession? = THUXSessionManager.session, otherTasks: [THUXSplashTask]?) {
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
            
            if let isAuthed = session?.isAuthenticated() {
                self.isAuthedProperty.value = isAuthed
            }
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
        
        isAuthedProperty.signal.observeValues { (isAuthed) in
            self.semaphoreProperty.value -= 1
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
    
    open func versionUpdatePrompt() -> UIViewController {
        //override me!
        return UIViewController()
    }
    
    // MARK: - Inputs
    
    open func viewDidLoad() {
        viewDidLoadProperty.value = ()
    }
    
    open func viewWillAppear() {
        viewWillAppearProperty.value = ()
    }
    
    open func viewDidAppear() {
        viewDidAppearProperty.value = ()
    }
}
