//
//  MockAPIManagerTests.swift
//  SportFlashTests
//
//  Created by ahmed osama on 05/06/2023.
//

import XCTest
@testable import SportFlash

class MockAPIManagerTests: XCTestCase {

    var networkManager : SportsAPIProtocol?
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testLoadDataFromURLShouldPass(){
        networkManager = MockNetworkManager(shouldReturnError: false)
        let sport = Sport.football
        let queryItems = [
            URLQueryItem(name: "met", value: "Leagues"),
            URLQueryItem(name: "APIkey", value: API_KYE)
        ]
        networkManager?.fetchData(for: sport, queryItems: queryItems) { (result: Result<[League]?, Error>) in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data, "Data should not be nil")
                        
                
            case .failure(let error):
                XCTFail("Fetch data failed with error: \(error.localizedDescription)")
            }
        }
    }
    func testLoadDataFromURLShouldFail(){
        networkManager = MockNetworkManager(shouldReturnError: true)
        let sport = Sport.football
        let queryItems = [
            URLQueryItem(name: "met", value: "Leagues"),
            URLQueryItem(name: "APIkey", value: API_KYE)
        ]
        networkManager?.fetchData(for: sport, queryItems: queryItems) { (result: Result<[League]?, Error>) in
            switch result {
            case .success(let data):
                XCTFail("Data should  be nil")

                        
                
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        }
    }

}
