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
    @Published var ResponseRatesBySurvey: [Int: [ChartData]]
    @Published var personalityScores: [String: PersonalityScore]
    let baseURL = "http://swiftware.tech"

    init() {
        // New class properties should be initialized in here
        self.ResponseRatesBySurvey = [Int : [ChartData]]()
        self.personalityScores = [String: PersonalityScore]()
    }

    // TODO: Implement Function
    /// Returned Data should be saved into ResponseRatesBySurvey
    /// Dictionary. Responses from the server come back as a list
    /// of ChartData objects, one ChartData instance per question
    ///  on the server. So if the returned ChartData items from
    ///  the server for surveyID: 1 is `chartDataList`, then it
    ///  can be saved using `ResposneRatesBySurvey[1] = chartDataList`
    func getAvgResponseRate(surveyID : Int) async {

    }

    func personalityScore(for user: String) async {
        print("Retrieving Score")
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
}
