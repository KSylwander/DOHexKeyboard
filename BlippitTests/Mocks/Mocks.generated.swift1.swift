// MARK: - Mocks generated from file: Blippit/Commons/Cancellable.swift at 2019-11-21 12:27:26 +0000

//
//  Cancellable.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-06.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

/* Conforming artifacts can be cancelled */

import Cuckoo
@testable import Blippit


 class MockCancellable: Cancellable, Cuckoo.ProtocolMock {
    
     typealias MocksType = Cancellable
    
     typealias Stubbing = __StubbingProxy_Cancellable
     typealias Verification = __VerificationProxy_Cancellable

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: Cancellable?

     func enableDefaultImplementation(_ stub: Cancellable) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func cancel()  {
        
    return cuckoo_manager.call("cancel()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.cancel())
        
    }
    

	 struct __StubbingProxy_Cancellable: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func cancel() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockCancellable.self, method: "cancel()", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_Cancellable: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func cancel() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("cancel()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class CancellableStub: Cancellable {
    

    

    
     func cancel()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}


// MARK: - Mocks generated from file: Blippit/Networking/DataTaskFactory.swift at 2019-11-21 12:27:26 +0000

//
//  DataTaskFactory.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-06.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Cuckoo
@testable import Blippit

import Foundation


 class MockDataTaskFactory: DataTaskFactory, Cuckoo.ProtocolMock {
    
     typealias MocksType = DataTaskFactory
    
     typealias Stubbing = __StubbingProxy_DataTaskFactory
     typealias Verification = __VerificationProxy_DataTaskFactory

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: DataTaskFactory?

     func enableDefaultImplementation(_ stub: DataTaskFactory) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        
    return cuckoo_manager.call("dataTask(with: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask",
            parameters: (request, completionHandler),
            escapingParameters: (request, completionHandler),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.dataTask(with: request, completionHandler: completionHandler))
        
    }
    

	 struct __StubbingProxy_DataTaskFactory: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func dataTask<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(with request: M1, completionHandler: M2) -> Cuckoo.ProtocolStubFunction<(URLRequest, (Data?, URLResponse?, Error?) -> Void), URLSessionDataTask> where M1.MatchedType == URLRequest, M2.MatchedType == (Data?, URLResponse?, Error?) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(URLRequest, (Data?, URLResponse?, Error?) -> Void)>] = [wrap(matchable: request) { $0.0 }, wrap(matchable: completionHandler) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockDataTaskFactory.self, method: "dataTask(with: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_DataTaskFactory: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func dataTask<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(with request: M1, completionHandler: M2) -> Cuckoo.__DoNotUse<(URLRequest, (Data?, URLResponse?, Error?) -> Void), URLSessionDataTask> where M1.MatchedType == URLRequest, M2.MatchedType == (Data?, URLResponse?, Error?) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(URLRequest, (Data?, URLResponse?, Error?) -> Void)>] = [wrap(matchable: request) { $0.0 }, wrap(matchable: completionHandler) { $0.1 }]
	        return cuckoo_manager.verify("dataTask(with: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class DataTaskFactoryStub: DataTaskFactory {
    

    

    
     func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask  {
        return DefaultValueRegistry.defaultValue(for: (URLSessionDataTask).self)
    }
    
}


// MARK: - Mocks generated from file: Blippit/Networking/HttpUrlResponseValidator.swift at 2019-11-21 12:27:26 +0000

//
//  HttpUrlResponseValidator.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-16.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Cuckoo
@testable import Blippit

import Foundation


 class MockHttpUrlResponseValidator: HttpUrlResponseValidator, Cuckoo.ProtocolMock {
    
     typealias MocksType = HttpUrlResponseValidator
    
     typealias Stubbing = __StubbingProxy_HttpUrlResponseValidator
     typealias Verification = __VerificationProxy_HttpUrlResponseValidator

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: HttpUrlResponseValidator?

     func enableDefaultImplementation(_ stub: HttpUrlResponseValidator) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func validate(_ response: HTTPURLResponse, data: Data?) -> Error? {
        
    return cuckoo_manager.call("validate(_: HTTPURLResponse, data: Data?) -> Error?",
            parameters: (response, data),
            escapingParameters: (response, data),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.validate(response, data: data))
        
    }
    

	 struct __StubbingProxy_HttpUrlResponseValidator: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func validate<M1: Cuckoo.Matchable, M2: Cuckoo.OptionalMatchable>(_ response: M1, data: M2) -> Cuckoo.ProtocolStubFunction<(HTTPURLResponse, Data?), Error?> where M1.MatchedType == HTTPURLResponse, M2.OptionalMatchedType == Data {
	        let matchers: [Cuckoo.ParameterMatcher<(HTTPURLResponse, Data?)>] = [wrap(matchable: response) { $0.0 }, wrap(matchable: data) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockHttpUrlResponseValidator.self, method: "validate(_: HTTPURLResponse, data: Data?) -> Error?", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_HttpUrlResponseValidator: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func validate<M1: Cuckoo.Matchable, M2: Cuckoo.OptionalMatchable>(_ response: M1, data: M2) -> Cuckoo.__DoNotUse<(HTTPURLResponse, Data?), Error?> where M1.MatchedType == HTTPURLResponse, M2.OptionalMatchedType == Data {
	        let matchers: [Cuckoo.ParameterMatcher<(HTTPURLResponse, Data?)>] = [wrap(matchable: response) { $0.0 }, wrap(matchable: data) { $0.1 }]
	        return cuckoo_manager.verify("validate(_: HTTPURLResponse, data: Data?) -> Error?", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class HttpUrlResponseValidatorStub: HttpUrlResponseValidator {
    

    

    
     func validate(_ response: HTTPURLResponse, data: Data?) -> Error?  {
        return DefaultValueRegistry.defaultValue(for: (Error?).self)
    }
    
}


// MARK: - Mocks generated from file: Blippit/State Handling/DefaultPodzStatusObservingState.swift at 2019-11-21 12:27:26 +0000

//
//  DefaultPodzStatusObservingState.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-07.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Cuckoo
@testable import Blippit

import Podz


 class MockDefaultPodzStatusObservingState: DefaultPodzStatusObservingState, Cuckoo.ProtocolMock {
    
     typealias MocksType = DefaultPodzStatusObservingState
    
     typealias Stubbing = __StubbingProxy_DefaultPodzStatusObservingState
     typealias Verification = __VerificationProxy_DefaultPodzStatusObservingState

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: DefaultPodzStatusObservingState?

     func enableDefaultImplementation(_ stub: DefaultPodzStatusObservingState) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
     var delegate: StateDelegate? {
        get {
            return cuckoo_manager.getter("delegate",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.delegate)
        }
        
    }
    

    

    
    
    
     func cancel()  {
        
    return cuckoo_manager.call("cancel()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.cancel())
        
    }
    

	 struct __StubbingProxy_DefaultPodzStatusObservingState: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var delegate: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockDefaultPodzStatusObservingState, StateDelegate?> {
	        return .init(manager: cuckoo_manager, name: "delegate")
	    }
	    
	    
	    func cancel() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockDefaultPodzStatusObservingState.self, method: "cancel()", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_DefaultPodzStatusObservingState: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	    
	    var delegate: Cuckoo.VerifyReadOnlyProperty<StateDelegate?> {
	        return .init(manager: cuckoo_manager, name: "delegate", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	    @discardableResult
	    func cancel() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("cancel()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class DefaultPodzStatusObservingStateStub: DefaultPodzStatusObservingState {
    
    
     var delegate: StateDelegate? {
        get {
            return DefaultValueRegistry.defaultValue(for: (StateDelegate?).self)
        }
        
    }
    

    

    
     func cancel()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}


// MARK: - Mocks generated from file: Blippit/State Handling/StateDelegate.swift at 2019-11-21 12:27:26 +0000

//
//  StateDelegate.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-07.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Cuckoo
@testable import Blippit

import Foundation


 class MockStateDelegate: StateDelegate, Cuckoo.ProtocolMock {
    
     typealias MocksType = StateDelegate
    
     typealias Stubbing = __StubbingProxy_StateDelegate
     typealias Verification = __VerificationProxy_StateDelegate

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: StateDelegate?

     func enableDefaultImplementation(_ stub: StateDelegate) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func state(_ state: State, moveFrom previousState: PreviousState)  {
        
    return cuckoo_manager.call("state(_: State, moveFrom: PreviousState)",
            parameters: (state, previousState),
            escapingParameters: (state, previousState),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.state(state, moveFrom: previousState))
        
    }
    
    
    
     func state(_ state: State, didFailWithError error: Error)  {
        
    return cuckoo_manager.call("state(_: State, didFailWithError: Error)",
            parameters: (state, error),
            escapingParameters: (state, error),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.state(state, didFailWithError: error))
        
    }
    

	 struct __StubbingProxy_StateDelegate: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func state<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ state: M1, moveFrom previousState: M2) -> Cuckoo.ProtocolStubNoReturnFunction<(State, PreviousState)> where M1.MatchedType == State, M2.MatchedType == PreviousState {
	        let matchers: [Cuckoo.ParameterMatcher<(State, PreviousState)>] = [wrap(matchable: state) { $0.0 }, wrap(matchable: previousState) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockStateDelegate.self, method: "state(_: State, moveFrom: PreviousState)", parameterMatchers: matchers))
	    }
	    
	    func state<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ state: M1, didFailWithError error: M2) -> Cuckoo.ProtocolStubNoReturnFunction<(State, Error)> where M1.MatchedType == State, M2.MatchedType == Error {
	        let matchers: [Cuckoo.ParameterMatcher<(State, Error)>] = [wrap(matchable: state) { $0.0 }, wrap(matchable: error) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockStateDelegate.self, method: "state(_: State, didFailWithError: Error)", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_StateDelegate: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func state<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ state: M1, moveFrom previousState: M2) -> Cuckoo.__DoNotUse<(State, PreviousState), Void> where M1.MatchedType == State, M2.MatchedType == PreviousState {
	        let matchers: [Cuckoo.ParameterMatcher<(State, PreviousState)>] = [wrap(matchable: state) { $0.0 }, wrap(matchable: previousState) { $0.1 }]
	        return cuckoo_manager.verify("state(_: State, moveFrom: PreviousState)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func state<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ state: M1, didFailWithError error: M2) -> Cuckoo.__DoNotUse<(State, Error), Void> where M1.MatchedType == State, M2.MatchedType == Error {
	        let matchers: [Cuckoo.ParameterMatcher<(State, Error)>] = [wrap(matchable: state) { $0.0 }, wrap(matchable: error) { $0.1 }]
	        return cuckoo_manager.verify("state(_: State, didFailWithError: Error)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class StateDelegateStub: StateDelegate {
    

    

    
     func state(_ state: State, moveFrom previousState: PreviousState)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func state(_ state: State, didFailWithError error: Error)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}


// MARK: - Mocks generated from file: BlippitTests/Mocks/DummyDefaultPodzStatusObservingState.swift at 2019-11-21 12:27:26 +0000

//
//  DummyDefaultPodzStatusObservingState.swift
//  BlippitTests
//
//  Created by Jerson Perpetua on 2019-05-07.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Cuckoo
@testable import Blippit

import Blippit


 class MockDummyDefaultPodzStatusObservingState: DummyDefaultPodzStatusObservingState, Cuckoo.ProtocolMock {
    
     typealias MocksType = DummyDefaultPodzStatusObservingState
    
     typealias Stubbing = __StubbingProxy_DummyDefaultPodzStatusObservingState
     typealias Verification = __VerificationProxy_DummyDefaultPodzStatusObservingState

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: DummyDefaultPodzStatusObservingState?

     func enableDefaultImplementation(_ stub: DummyDefaultPodzStatusObservingState) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
     var delegate: StateDelegate? {
        get {
            return cuckoo_manager.getter("delegate",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.delegate)
        }
        
    }
    

    

    
    
    
     func cancel()  {
        
    return cuckoo_manager.call("cancel()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.cancel())
        
    }
    

	 struct __StubbingProxy_DummyDefaultPodzStatusObservingState: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var delegate: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockDummyDefaultPodzStatusObservingState, StateDelegate?> {
	        return .init(manager: cuckoo_manager, name: "delegate")
	    }
	    
	    
	    func cancel() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockDummyDefaultPodzStatusObservingState.self, method: "cancel()", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_DummyDefaultPodzStatusObservingState: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	    
	    var delegate: Cuckoo.VerifyReadOnlyProperty<StateDelegate?> {
	        return .init(manager: cuckoo_manager, name: "delegate", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	    @discardableResult
	    func cancel() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("cancel()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class DummyDefaultPodzStatusObservingStateStub: DummyDefaultPodzStatusObservingState {
    
    
     var delegate: StateDelegate? {
        get {
            return DefaultValueRegistry.defaultValue(for: (StateDelegate?).self)
        }
        
    }
    

    

    
     func cancel()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}


// MARK: - Mocks generated from file: BlippitTests/Mocks/DummyPod.swift at 2019-11-21 12:27:26 +0000

//
//  DummyPod.swift
//  BlippitTests
//
//  Created by Jerson Perpetua on 2019-05-08.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Cuckoo
@testable import Blippit

import Podz


 class MockDummyPod: DummyPod, Cuckoo.ProtocolMock {
    
     typealias MocksType = DummyPod
    
     typealias Stubbing = __StubbingProxy_DummyPod
     typealias Verification = __VerificationProxy_DummyPod

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: DummyPod?

     func enableDefaultImplementation(_ stub: DummyPod) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
     var pid: UInt32 {
        get {
            return cuckoo_manager.getter("pid",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.pid)
        }
        
    }
    
    
    
     var state: PodState {
        get {
            return cuckoo_manager.getter("state",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.state)
        }
        
    }
    
    
    
     var onStateChanged: ((Pod, PodState) -> Void)? {
        get {
            return cuckoo_manager.getter("onStateChanged",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.onStateChanged)
        }
        
        set {
            cuckoo_manager.setter("onStateChanged",
                value: newValue,
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.onStateChanged = newValue)
        }
        
    }
    
    
    
     var onUpdated: ((Pod, Date, Int, Int, Int) -> Void)? {
        get {
            return cuckoo_manager.getter("onUpdated",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.onUpdated)
        }
        
        set {
            cuckoo_manager.setter("onUpdated",
                value: newValue,
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.onUpdated = newValue)
        }
        
    }
    

    

    

	 struct __StubbingProxy_DummyPod: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var pid: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockDummyPod, UInt32> {
	        return .init(manager: cuckoo_manager, name: "pid")
	    }
	    
	    
	    var state: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockDummyPod, PodState> {
	        return .init(manager: cuckoo_manager, name: "state")
	    }
	    
	    
	    var onStateChanged: Cuckoo.ProtocolToBeStubbedOptionalProperty<MockDummyPod, ((Pod, PodState) -> Void)> {
	        return .init(manager: cuckoo_manager, name: "onStateChanged")
	    }
	    
	    
	    var onUpdated: Cuckoo.ProtocolToBeStubbedOptionalProperty<MockDummyPod, ((Pod, Date, Int, Int, Int) -> Void)> {
	        return .init(manager: cuckoo_manager, name: "onUpdated")
	    }
	    
	    
	}

	 struct __VerificationProxy_DummyPod: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	    
	    var pid: Cuckoo.VerifyReadOnlyProperty<UInt32> {
	        return .init(manager: cuckoo_manager, name: "pid", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var state: Cuckoo.VerifyReadOnlyProperty<PodState> {
	        return .init(manager: cuckoo_manager, name: "state", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var onStateChanged: Cuckoo.VerifyOptionalProperty<((Pod, PodState) -> Void)> {
	        return .init(manager: cuckoo_manager, name: "onStateChanged", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var onUpdated: Cuckoo.VerifyOptionalProperty<((Pod, Date, Int, Int, Int) -> Void)> {
	        return .init(manager: cuckoo_manager, name: "onUpdated", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	}
}

 class DummyPodStub: DummyPod {
    
    
     var pid: UInt32 {
        get {
            return DefaultValueRegistry.defaultValue(for: (UInt32).self)
        }
        
    }
    
    
     var state: PodState {
        get {
            return DefaultValueRegistry.defaultValue(for: (PodState).self)
        }
        
    }
    
    
     var onStateChanged: ((Pod, PodState) -> Void)? {
        get {
            return DefaultValueRegistry.defaultValue(for: (((Pod, PodState) -> Void)?).self)
        }
        
        set { }
        
    }
    
    
     var onUpdated: ((Pod, Date, Int, Int, Int) -> Void)? {
        get {
            return DefaultValueRegistry.defaultValue(for: (((Pod, Date, Int, Int, Int) -> Void)?).self)
        }
        
        set { }
        
    }
    

    

    
}


// MARK: - Mocks generated from file: BlippitTests/Mocks/DummyPodSession.swift at 2019-11-21 12:27:26 +0000

//
//  DummyPodSession.swift
//  BlippitTests
//
//  Created by Jerson Perpetua on 2019-05-08.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Cuckoo
@testable import Blippit

import Podz


 class MockDummyPodSession: DummyPodSession, Cuckoo.ProtocolMock {
    
     typealias MocksType = DummyPodSession
    
     typealias Stubbing = __StubbingProxy_DummyPodSession
     typealias Verification = __VerificationProxy_DummyPodSession

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: DummyPodSession?

     func enableDefaultImplementation(_ stub: DummyPodSession) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
     var state: PodSessionState {
        get {
            return cuckoo_manager.getter("state",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.state)
        }
        
    }
    
    
    
     var onSessionStateChanged: ((PodSession, PodSessionState) -> Void)? {
        get {
            return cuckoo_manager.getter("onSessionStateChanged",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.onSessionStateChanged)
        }
        
        set {
            cuckoo_manager.setter("onSessionStateChanged",
                value: newValue,
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.onSessionStateChanged = newValue)
        }
        
    }
    

    

    
    
    
     func open() throws {
        
    return try cuckoo_manager.callThrows("open() throws",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.open())
        
    }
    
    
    
     func close() throws {
        
    return try cuckoo_manager.callThrows("close() throws",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.close())
        
    }
    
    
    
     func availableTransactions() throws -> [TransactionType] {
        
    return try cuckoo_manager.callThrows("availableTransactions() throws -> [TransactionType]",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.availableTransactions())
        
    }
    
    
    
     func perform(transaction: Transaction) throws {
        
    return try cuckoo_manager.callThrows("perform(transaction: Transaction) throws",
            parameters: (transaction),
            escapingParameters: (transaction),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.perform(transaction: transaction))
        
    }
    

	 struct __StubbingProxy_DummyPodSession: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var state: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockDummyPodSession, PodSessionState> {
	        return .init(manager: cuckoo_manager, name: "state")
	    }
	    
	    
	    var onSessionStateChanged: Cuckoo.ProtocolToBeStubbedOptionalProperty<MockDummyPodSession, ((PodSession, PodSessionState) -> Void)> {
	        return .init(manager: cuckoo_manager, name: "onSessionStateChanged")
	    }
	    
	    
	    func open() -> Cuckoo.ProtocolStubNoReturnThrowingFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockDummyPodSession.self, method: "open() throws", parameterMatchers: matchers))
	    }
	    
	    func close() -> Cuckoo.ProtocolStubNoReturnThrowingFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockDummyPodSession.self, method: "close() throws", parameterMatchers: matchers))
	    }
	    
	    func availableTransactions() -> Cuckoo.ProtocolStubThrowingFunction<(), [TransactionType]> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockDummyPodSession.self, method: "availableTransactions() throws -> [TransactionType]", parameterMatchers: matchers))
	    }
	    
	    func perform<M1: Cuckoo.Matchable>(transaction: M1) -> Cuckoo.ProtocolStubNoReturnThrowingFunction<(Transaction)> where M1.MatchedType == Transaction {
	        let matchers: [Cuckoo.ParameterMatcher<(Transaction)>] = [wrap(matchable: transaction) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockDummyPodSession.self, method: "perform(transaction: Transaction) throws", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_DummyPodSession: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	    
	    var state: Cuckoo.VerifyReadOnlyProperty<PodSessionState> {
	        return .init(manager: cuckoo_manager, name: "state", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var onSessionStateChanged: Cuckoo.VerifyOptionalProperty<((PodSession, PodSessionState) -> Void)> {
	        return .init(manager: cuckoo_manager, name: "onSessionStateChanged", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	    @discardableResult
	    func open() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("open() throws", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func close() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("close() throws", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func availableTransactions() -> Cuckoo.__DoNotUse<(), [TransactionType]> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("availableTransactions() throws -> [TransactionType]", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func perform<M1: Cuckoo.Matchable>(transaction: M1) -> Cuckoo.__DoNotUse<(Transaction), Void> where M1.MatchedType == Transaction {
	        let matchers: [Cuckoo.ParameterMatcher<(Transaction)>] = [wrap(matchable: transaction) { $0 }]
	        return cuckoo_manager.verify("perform(transaction: Transaction) throws", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class DummyPodSessionStub: DummyPodSession {
    
    
     var state: PodSessionState {
        get {
            return DefaultValueRegistry.defaultValue(for: (PodSessionState).self)
        }
        
    }
    
    
     var onSessionStateChanged: ((PodSession, PodSessionState) -> Void)? {
        get {
            return DefaultValueRegistry.defaultValue(for: (((PodSession, PodSessionState) -> Void)?).self)
        }
        
        set { }
        
    }
    

    

    
     func open() throws  {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func close() throws  {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func availableTransactions() throws -> [TransactionType]  {
        return DefaultValueRegistry.defaultValue(for: ([TransactionType]).self)
    }
    
     func perform(transaction: Transaction) throws  {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}


// MARK: - Mocks generated from file: BlippitTests/Mocks/DummyPodz.swift at 2019-11-21 12:27:26 +0000

//
//  DummyPodz.swift
//  BlippitTests
//
//  Created by Jerson Perpetua on 2019-05-07.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Cuckoo
@testable import Blippit

import Podz


 class MockDummyPodz: DummyPodz, Cuckoo.ProtocolMock {
    
     typealias MocksType = DummyPodz
    
     typealias Stubbing = __StubbingProxy_DummyPodz
     typealias Verification = __VerificationProxy_DummyPodz

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: DummyPodz?

     func enableDefaultImplementation(_ stub: DummyPodz) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
     var status: PodzStatus {
        get {
            return cuckoo_manager.getter("status",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.status)
        }
        
    }
    
    
    
     var onPodFound: ((Pod) -> Void)? {
        get {
            return cuckoo_manager.getter("onPodFound",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.onPodFound)
        }
        
        set {
            cuckoo_manager.setter("onPodFound",
                value: newValue,
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.onPodFound = newValue)
        }
        
    }
    
    
    
     var onPodLost: ((Pod) -> Void)? {
        get {
            return cuckoo_manager.getter("onPodLost",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.onPodLost)
        }
        
        set {
            cuckoo_manager.setter("onPodLost",
                value: newValue,
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.onPodLost = newValue)
        }
        
    }
    
    
    
     var onStatusChanged: ((PodzStatus) -> Void)? {
        get {
            return cuckoo_manager.getter("onStatusChanged",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.onStatusChanged)
        }
        
        set {
            cuckoo_manager.setter("onStatusChanged",
                value: newValue,
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.onStatusChanged = newValue)
        }
        
    }
    

    

    
    
    
     func start()  {
        
    return cuckoo_manager.call("start()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.start())
        
    }
    
    
    
     func stop()  {
        
    return cuckoo_manager.call("stop()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.stop())
        
    }
    

	 struct __StubbingProxy_DummyPodz: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var status: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockDummyPodz, PodzStatus> {
	        return .init(manager: cuckoo_manager, name: "status")
	    }
	    
	    
	    var onPodFound: Cuckoo.ProtocolToBeStubbedOptionalProperty<MockDummyPodz, ((Pod) -> Void)> {
	        return .init(manager: cuckoo_manager, name: "onPodFound")
	    }
	    
	    
	    var onPodLost: Cuckoo.ProtocolToBeStubbedOptionalProperty<MockDummyPodz, ((Pod) -> Void)> {
	        return .init(manager: cuckoo_manager, name: "onPodLost")
	    }
	    
	    
	    var onStatusChanged: Cuckoo.ProtocolToBeStubbedOptionalProperty<MockDummyPodz, ((PodzStatus) -> Void)> {
	        return .init(manager: cuckoo_manager, name: "onStatusChanged")
	    }
	    
	    
	    func start() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockDummyPodz.self, method: "start()", parameterMatchers: matchers))
	    }
	    
	    func stop() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockDummyPodz.self, method: "stop()", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_DummyPodz: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	    
	    var status: Cuckoo.VerifyReadOnlyProperty<PodzStatus> {
	        return .init(manager: cuckoo_manager, name: "status", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var onPodFound: Cuckoo.VerifyOptionalProperty<((Pod) -> Void)> {
	        return .init(manager: cuckoo_manager, name: "onPodFound", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var onPodLost: Cuckoo.VerifyOptionalProperty<((Pod) -> Void)> {
	        return .init(manager: cuckoo_manager, name: "onPodLost", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var onStatusChanged: Cuckoo.VerifyOptionalProperty<((PodzStatus) -> Void)> {
	        return .init(manager: cuckoo_manager, name: "onStatusChanged", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	    @discardableResult
	    func start() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("start()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func stop() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("stop()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class DummyPodzStub: DummyPodz {
    
    
     var status: PodzStatus {
        get {
            return DefaultValueRegistry.defaultValue(for: (PodzStatus).self)
        }
        
    }
    
    
     var onPodFound: ((Pod) -> Void)? {
        get {
            return DefaultValueRegistry.defaultValue(for: (((Pod) -> Void)?).self)
        }
        
        set { }
        
    }
    
    
     var onPodLost: ((Pod) -> Void)? {
        get {
            return DefaultValueRegistry.defaultValue(for: (((Pod) -> Void)?).self)
        }
        
        set { }
        
    }
    
    
     var onStatusChanged: ((PodzStatus) -> Void)? {
        get {
            return DefaultValueRegistry.defaultValue(for: (((PodzStatus) -> Void)?).self)
        }
        
        set { }
        
    }
    

    

    
     func start()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func stop()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}


// MARK: - Mocks generated from file: BlippitTests/Mocks/DummyURLSessionDataTask.swift at 2019-11-21 12:27:26 +0000

//
//  DummyURLSessionDataTask.swift
//  BlippitTests
//
//  Created by Jerson Perpetua on 2019-05-06.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Cuckoo
@testable import Blippit

import Foundation


 class MockDummyURLSessionDataTask: DummyURLSessionDataTask, Cuckoo.ClassMock {
    
     typealias MocksType = DummyURLSessionDataTask
    
     typealias Stubbing = __StubbingProxy_DummyURLSessionDataTask
     typealias Verification = __VerificationProxy_DummyURLSessionDataTask

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: DummyURLSessionDataTask?

     func enableDefaultImplementation(_ stub: DummyURLSessionDataTask) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     override func resume()  {
        
    return cuckoo_manager.call("resume()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.resume()
                ,
            defaultCall: __defaultImplStub!.resume())
        
    }
    

	 struct __StubbingProxy_DummyURLSessionDataTask: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func resume() -> Cuckoo.ClassStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockDummyURLSessionDataTask.self, method: "resume()", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_DummyURLSessionDataTask: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func resume() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("resume()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class DummyURLSessionDataTaskStub: DummyURLSessionDataTask {
    

    

    
     override func resume()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}

