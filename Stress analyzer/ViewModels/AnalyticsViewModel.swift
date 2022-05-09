//
//  AnalyticsViewModel.swift
//  Stress Analyzer
//
//  Created by Shawn Long on 5/6/22.
//

import Foundation

@MainActor
final class AnalyticsViewModel: ObservableObject {
    /// The ResponseRatesBySurvey Dictionary has keys
    /// of surveyID, and values of [ChartData] which
    /// represent the list of ChartData objects for
    /// each question of the survey.
    @Published var ResponseRatesBySurvey: [Int : [ChartData]]
    @Published var PersonalityScores: [PersonalityScore]

    init() {
        // New class properties should be initialized in here
        self.ResponseRatesBySurvey = [Int: [ChartData]]()
        self.PersonalityScores = [PersonalityScore]()
    }

    // TODO: Implement Function
    /// Returned Data should be saved into ResponseRatesBySurvey
    /// Dictionary. Responses from the server come back as a list
    /// of ChartData objects, one ChartData instance per question
    ///  on the server. So if the returned ChartData items from
    ///  the server for surveyID: 1 is `chartDataList`, then it
    ///  can be saved using `ResposneRatesBySurvey[1] = chartDataList`
    func getAvgResponseRate(surveyID: Int) async {

    }

    // TODO: Implement Function
    func personalityScore(forUser: Int) async {
        
    }
}
