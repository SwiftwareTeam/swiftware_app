//
//  Survey.swift
//  Stress analyzer
//
//  Created by Shawn Long on 4/23/22.
//

import Foundation

struct Question: Codable {
    var id: String
    var shortWording: String
    var fullWording: String
}

struct Answer: Codable {
    var id: String
    var label: String
    var value: Int
}

struct Survey: Codable {
    var name: String
    var group: String
    var questions: [String : Question] // QuestionID: Question
    var answers: [String : Answer] // AnswerID: Answer
}
