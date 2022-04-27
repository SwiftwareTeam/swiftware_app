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
//        func testNewGetResponse() async throws {
//            let url = URL(string: "http://127.0.0.1:8080/getResponses/shawnlong636")!
//            let request = URLRequest(url: url)
//
//            let (data, response) = try await URLSession.shared.data(for: request)
//
//            XCTAssertNotNil(response)
//            XCTAssertNotNil(data)
//
//            let httpResponse = response as? HTTPURLResponse
//            let surveyResponse: [SurveyResponse]?
//
//            let decoder = JSONDecoder()
//
//            XCTAssertEqual(httpResponse?.statusCode, 200)
//
//            surveyResponse = try decoder.decode([SurveyResponse].self, from: data)
//
//            print(surveyResponse?[0].responses)
//
//            XCTAssertNotNil(surveyResponse)
//
//        }
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

//    func testGetNulSurveyResponse() async throws {
//        let url = URL(string: "http://127.0.0.1:8080/Test")! // Endpoint deleted, just sends single SurveyResponse with a nil
//        let request = URLRequest(url: url)
//
//        let (data, response) = try await URLSession.shared.data(for: request)
//
//        XCTAssertNotNil(response)
//        XCTAssertNotNil(data)
//
//        let httpResponse = response as? HTTPURLResponse
//        let surveyResponse: SurveyResponse?
//
//        let decoder = JSONDecoder()
//
//        XCTAssertEqual(httpResponse?.statusCode, 200)
//
//        surveyResponse = try decoder.decode(SurveyResponse.self, from: data)
//
//        let value: Int? = surveyResponse?.responses[1] ?? nil
//
//        if value == nil {
//            print("Value is nil")
//        } else {
//            print("Value is not nil")
//        }
//    }
//    func testCreateResposnse() async throws {
//        let url = URL(string: "http://127.0.0.1:8080/createResponse")!
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//
//        let surveyResponse = SurveyResponse(uid: "shawnlong636", surveyID: 1, responseType: "new", responses: [1: 3, 2: 2, 3:4])
//
//        let encoder = JSONEncoder()
//        let encoded = try encoder.encode(surveyResponse)
//
//        let (data, response) = try await URLSession.shared.upload(for: request, from: encoded)

//        let responseStr = String(decoding: data, as: UTF8.self)
//        print(responseStr)


//    }

}
