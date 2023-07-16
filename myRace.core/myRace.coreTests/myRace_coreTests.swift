//
//  myRace_coreTests.swift
//  myRace.coreTests
//
//  Created by Yanbo Dang on 12/7/2023.
//

import XCTest
import Combine
@testable import myRace_core

final class myRace_coreTests: XCTestCase {

    private var cancellables: Set<AnyCancellable> = []
    private let serviceLocator = ServiceLocatorImpl.shareInstance()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    
        self.initServiceLocator(serviceLocator: self.serviceLocator)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        let httpService: HttpService? = self.serviceLocator.resolve()
        let viewModel = RaceViewModel(httpService: httpService!)
        viewModel.$refreshedDate.receive(on: RunLoop.main)
            .sink { curDate in
                XCTAssert(viewModel.nextRaceItems.count == 3)
                XCTAssert(viewModel.nextRaceItems[0].id == "1")
                XCTAssert(viewModel.nextRaceItems[0].id == "3")
                XCTAssert(viewModel.nextRaceItems[0].id == "2")
                return
            }.store(in: &self.cancellables)
        
        viewModel.initViewModel()
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    private func initServiceLocator(serviceLocator: ServiceLocator) {
        let httpService: HttpService = MockHttpService()
        serviceLocator.register(instance: httpService)
    }

}
