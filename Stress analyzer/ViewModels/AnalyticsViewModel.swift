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
    @Published var responseRatesBySurvey: [Int: [ChartData]]
    @Published var personalityScores: [String: PersonalityScore]
    let baseURL = "http://swiftware.tech"
//    let baseURL = "http://127.0.0.1:8080"

    init() {
        // New class properties should be initialized in here
        self.responseRatesBySurvey =  [Int: [ChartData]]()
        self.personalityScores = [String: PersonalityScore]()
    }

    func getAvgResponseRate(surveyID : Int) async {
        print("Retreiving chart data for avg response")
        let url = URL(string: baseURL + "/avgResponseRate/" + String(surveyID))!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let chartDataArray = try JSONDecoder().decode([ChartData].self, from: data)
            print("Retrieved \(chartDataArray.count) charts for survey \(surveyID)")
            self.responseRatesBySurvey[surveyID] = chartDataArray
            
        } catch {
            print("unable to retrieve average response rates. Reason: \(error)")
        }
    }

    func personalityScore(for user: String) async {
        guard let url = URL(string: "\(baseURL)/getPersonalityScore/\(user)") else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        do {
            let (data, response ) = try await URLSession.shared.data(for: request)

            guard let HttpResponse = response as? HTTPURLResponse else {
                print("Unable to decode response as HTTPURLResponse")
                return
            }
            guard HttpResponse.statusCode == 200 else {
                print("Status Code: \(HttpResponse.statusCode) != 200")
                return
            }

            if let personalityScore = try? JSONDecoder().decode(PersonalityScore.self, from: data) {
                personalityScores[user] = personalityScore
            }
        } catch {
            print("unable to retrieve Personality Score from server. Reason: \(error)")
        }
    }

    func getMeasureValues(surveyID: Int, questionID: Int) -> [Double] {
        guard let chartDataArray = self.responseRatesBySurvey[surveyID] else {
            print("Chart Data Array for Survey \(surveyID) not found")
            return [Double]()

        }

        guard (questionID - 1) < chartDataArray.count else {
            print("Question ID Out of  Bounds of Chart Data object")
            return [Double]()
        }

        return chartDataArray[questionID - 1].measureValues
    }
}
