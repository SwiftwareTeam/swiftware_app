//
//  Survey.swift
//  Stress analyzer
//
//  Created by Shawn Long on 4/23/22.
//

import Foundation

struct Question: Codable {
    var id: Int
    var shortWording: String
    var fullWording: String
}

struct Answer: Codable {
    var id: Int
    var label: String
    var value: Int
}

struct Survey: Codable {
    var id: Int
    var name: String
    var group: String
    var questions: [Int : Question] // QuestionID: Question
    var answers: [Int : Answer] // AnswerID: Answer
}
