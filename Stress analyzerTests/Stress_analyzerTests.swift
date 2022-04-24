//
//  Stress_analyzerTests.swift
//  Stress analyzerTests
//
//  Created by Adrian on 4/12/22.
//

import XCTest
@testable import Stress_analyzer

class Stress_analyzerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

//    func testNewGetResponse() async throws {
//        let url = URL(string: "http://swiftware.tech/getResponses/u00")!
//        let request = URLRequest(url: url)
//
//        let (data, response) = try await URLSession.shared.data(for: request)
//
//        XCTAssertNotNil(response)
//        XCTAssertNotNil(data)
//
//        let httpResponse = response as? HTTPURLResponse
//        let surveyResponse: [SurveyResponse]?
//
//        let decoder = JSONDecoder()
//
//        XCTAssertEqual(httpResponse?.statusCode, 200)
//
//        surveyResponse = try decoder.decode([SurveyResponse].self, from: data)
//
//        XCTAssertNotNil(surveyResponse)
//
//    }
//
//    func testGetSurvey() async throws {
//        let url = URL(string: "http:/swiftware.tech/getSurveys")!
//        let request = URLRequest(url: url)
//
//        let (data, response) = try await URLSession.shared.data(for: request)
//
//        XCTAssertNotNil(response)
//        XCTAssertNotNil(data)
//
//        let httpResponse = response as? HTTPURLResponse
//        let surveys: [Survey]?
//
//        let decoder = JSONDecoder()
//
//        XCTAssertEqual(httpResponse?.statusCode, 200)
//
//        surveys = try decoder.decode([Survey].self, from: data)
//    }

}
