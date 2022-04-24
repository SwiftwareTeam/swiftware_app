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

    func testNewGetResponse() async throws {
        let url = URL(string: "http://127.0.0.1:8080/test")!
        let request = URLRequest(url: url)

        let (data, response) = try await URLSession.shared.data(for: request)

        XCTAssertNotNil(response)
        XCTAssertNotNil(data)

        let httpResponse = response as? HTTPURLResponse
        let surveyResponse: SurveyResponse?

        let decoder = JSONDecoder()

        XCTAssertEqual(httpResponse?.statusCode, 200)

        surveyResponse = try decoder.decode(SurveyResponse.self, from: data)

        XCTAssertEqual(surveyResponse?.uid, "u000")
        XCTAssertEqual(surveyResponse?.responseType, "pre")
        XCTAssertEqual(surveyResponse?.surveyID, "S1")
        XCTAssertEqual(surveyResponse?.responses["Q1-1"], "Q1-1-1")
        XCTAssertEqual(surveyResponse?.responses["Q1-2"], "Q1-2-3")

    }

    func testGetSurvey() async throws {
        let url = URL(string: "http://127.0.0.1:8080/test2")!
        let request = URLRequest(url: url)

        let (data, response) = try await URLSession.shared.data(for: request)

        XCTAssertNotNil(response)
        XCTAssertNotNil(data)

        let httpResponse = response as? HTTPURLResponse
        let survey: Survey?

        let decoder = JSONDecoder()

        XCTAssertEqual(httpResponse?.statusCode, 200)

        survey = try decoder.decode(Survey.self, from: data)

        XCTAssertEqual(survey?.name, "Big Five")
        XCTAssertEqual(survey?.group, "I see myself as")

        XCTAssertEqual(survey?.questions["Q1-1"]?.shortWording, "Talkative")
        XCTAssertEqual(survey?.questions["Q1-2"]?.fullWording, "I see myself as someone who tends to find fault with others")
    }

}
