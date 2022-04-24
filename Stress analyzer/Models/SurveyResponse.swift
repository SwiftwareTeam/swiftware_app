//
//  SurveyResponse.swift
//  Stress analyzer
//
//  Created by Shawn Long on 4/23/22.
//

import Foundation

struct SurveyResponse: Codable {
    var id = UUID()
    var uid: String
    var surveyID: Int
    var responseType: String
    var responses: [Int : Int] // QuestionID: AnswerID (Must be looked up from Survey Object)
}
