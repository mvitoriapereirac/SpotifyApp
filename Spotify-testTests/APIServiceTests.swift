//
//  APIServiceTests.swift
//  Spotify-testTests
//
//  Created by mvitoriapereirac on 01/12/23.
//

import XCTest
//import OHHTTPStubs


@testable import Spotify_test
final class APIServiceTests: XCTestCase {
    let apiService = APIService(networkService: MockNetworkService())
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
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
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testGetRecentlyListened_SuccessfulResponse() {
        let expectation = expectation(description: "Fetching recently listened")
        
        // Call the asynchronous method I want to test
        let task = Task {
            do {
                // Await the method being tested
                try await apiService.getRecentlyListened()
                
                // Assert: Validate the results or behavior based on the awaited method
                print(apiService.dict)
                XCTAssertEqual(apiService.dict.count, 22)
                
                // Fulfill the expectation, indicating the async operation completed successfully
                expectation.fulfill()
                
            } catch {
                // Fail the test in case of an error during the async operation
                XCTFail("Error: \(error)")
            }
        }
        
        // Wait for the expectation to be fulfilled within a certain time
        waitForExpectations(timeout: 5) { error in
            if let error = error {
                XCTFail("Timeout waiting for expectation: \(error)")
            }
            
            // After the expectation is fulfilled or timed out, explicitly cancel the task
            task.cancel()
        }
    }
    
}
