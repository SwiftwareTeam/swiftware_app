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
    @Published var ResponseRatesBySurvey: [ChartData]
    @Published var personalityScores: [String: PersonalityScore]
    let baseURL = "http://swiftware.tech"

    init() {
        // New class properties should be initialized in here
        self.ResponseRatesBySurvey =  [ChartData]()
        self.personalityScores = [String: PersonalityScore]()
    }

    func getAvgResponseRate(surveyID : Int) async {
        let url = URL(string: baseURL + "avgResponseRate/" + String(surveyID))!
        //print ("url: " , url)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        do {
            print ("inside do task")
            let (data, _) = try await URLSession.shared.data(for: request)
            ResponseRatesBySurvey = try JSONDecoder().decode([ChartData].self, from: data)
        
            print(ResponseRatesBySurvey[surveyID])
            
        } catch {
            print("unable to retrieve average response rates. Reason: \(error)")
        }
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
