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
    @Published var ResponseRatesBySurvey : [ChartData] //holds all the respose rates for each question. can be accessed by ResponseratesBySurvey[surveyID]
    let baseURL = "http://swiftware.tech"

    init() {
        // New class properties should be initialized in here
        self.ResponseRatesBySurvey = [ChartData]()
    }

    func getAvgResponseRate(surveyID : Int) async {
        let url = URL(string: baseURL + "/avgResponseRate/" + String(surveyID))!
        print ("url: " , url)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        do {
            print ("inside do task")
            let (data, _) = try await URLSession.shared.data(for: request)
            ResponseRatesBySurvey = try JSONDecoder().decode([ChartData].self, from: data)
        
            //print(ResponseRatesBySurvey[surveyID])
            
        } catch {
            print("unable to retrieve average response rates. Reason: \(error)")
        }
    }
}
