//
//  SurveyResponse.swift
//  Stress analyzer
//
//  Created by Shawn Long on 4/23/22.
//

import Foundation

struct SurveyResponse: Codable {
    var id: UUID
    var uid: String
    var responseType: String
    var questions: [String]
    var answers: [String]
}
