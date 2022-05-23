//
//  SurveyViewModel.swift
//  Stress Analyzer
//
//  Created by Shawn Long on 5/4/22.
//

import Foundation

/**
 This is the ViewModel which contains the list  of survey objects retrieved from the Swiftware Server.
 */
@MainActor
final class SurveyViewModel: ObservableObject {
    @Published var surveys : [Int: Survey] /// surveyID: Survey
    let baseURL = "http://swiftware.tech"
    
    init() {
        // New class properties should be initialized in here
        self.surveys = [Int: Survey]()
    }

    // TODO: Implement Function
    func getSurveys() async {
        guard let url = URL(string: baseURL + "/getSurveys") else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        do {
            let (data, _ ) = try await URLSession.shared.data(for: request)
            
            if let surveyArray = try? JSONDecoder().decode([Survey].self, from: data) {
                self.surveys = Dictionary(uniqueKeysWithValues: surveyArray.map { ($0.id, $0)} )
            }
            
            
        } catch {
            print("Error: \(error)")
        }
    }
}
