//
//  SportsAPITests.swift
//  SportFlashTests
//
//  Created by ahmed osama on 05/06/2023.
//

import XCTest
@testable import SportFlash

class SportsAPITests: XCTestCase {
    var sportsAPI: SportsAPI!
    
    override func setUp() {
        super.setUp()
        sportsAPI = SportsAPI()
    }
    
    override func tearDown() {
        sportsAPI = nil
        super.tearDown()
    }
    func testFailFetchLeague() {
        let expectation = XCTestExpectation(description: "Fetch data completion called")
        
        // Set up test data
        let sport = Sport.football
        let queryItems = [
            URLQueryItem(name: "met", value: "Leues"),
            URLQueryItem(name: "APIkey", value: API_KYE)
        ]
        sportsAPI.fetchData(for: sport, queryItems: queryItems) { (result: Result<[League]?, Error>) in
            switch result {
            case .success(_):
                
                // Perform additional assertions on the fetched data if needed
                XCTFail("Fetch data failed with sucssed")

                
            case .failure(_):
                expectation.fulfill()

            }
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testFetchLeague() {
        let expectation = XCTestExpectation(description: "Fetch data completion called")
        
        // Set up test data
        let sport = Sport.football
        let queryItems = [
            URLQueryItem(name: "met", value: "Leagues"),
            URLQueryItem(name: "APIkey", value: API_KYE)
        ]
        sportsAPI.fetchData(for: sport, queryItems: queryItems) { (result: Result<[League]?, Error>) in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data, "Data should not be nil")
                
                // Perform additional assertions on the fetched data if needed
                
                expectation.fulfill()
                
            case .failure(let error):
                XCTFail("Fetch data failed with error: \(error.localizedDescription)")
            }
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
}
