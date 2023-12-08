//
//  APIServiceTests.swift
//  Spotify-testTests
//
//  Created by mvitoriapereirac on 01/12/23.
//

import XCTest
import OHHTTPStubs


@testable import Spotify_test
final class APIServiceTests: XCTestCase {
    let apiService = APIService()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
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
        // Mock a URLRequest for testing
        let testURL = "https://mockurl.com"

        // Get mock data for the response
        let mockData = Data() // Replace Data() with your mock JSON data

        let mockedData = createMockLastListenedResponse()

        // Stub the network request using a mock library or your own stub mechanism
        // For example:
        stub(condition: isHost(testURL)) { _ in
                    return HTTPStubsResponse(data: mockData, statusCode: 200, headers: nil)
                }
//        MockNetworkStub.stubRequest(for: testRequest, withResponseData: mockData, statusCode: 200)

//        let expectation = XCTestExpectation(description: "Fetching recently listened")

        // Test the API service function with the mocked URLRequest
        // Create an expectation for the asynchronous call
              let expectation = expectation(description: "Fetching recently listened")
              
              // Call the asynchronous method you want to test
        Task {
                    do {
                        let _ = try await apiService.getRecentlyListened()
                        
                        // Fulfill the expectation once the async operation is complete
                        expectation.fulfill()
                    } catch {
                        XCTFail("Error: \(error)") // Fail the test in case of an error
                    }
                }
              
              // Wait for the expectation to be fulfilled within a certain time
              waitForExpectations(timeout: 5) // Adjust the timeout as needed
          }

}
