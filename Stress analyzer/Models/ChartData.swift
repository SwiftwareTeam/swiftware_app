//
//  ChartData.swift
//  
//
//  Created by Shawn Long on 4/30/22.
//

import Foundation

struct ChartData : Codable {
    var surveyID: Int
    var questionID: Int
    var dimensionName : String
    var measureName : String
    var dimensionValues : [Int]
    var measureValues : [Double]
}
