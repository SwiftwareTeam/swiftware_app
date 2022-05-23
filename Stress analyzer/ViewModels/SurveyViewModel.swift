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
    @Published var surveys : [Survey]
    let baseURL = "http://swiftware.tech"
    
    init() {
        // New class properties should be initialized in here
        self.surveys = [Survey]()
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
            
            if let ss = try? JSONDecoder().decode([Survey].self, from: data) {
                //self.users = userList
                
                self.surveys = ss
                print(surveys)
            }
            
            
        } catch {
            print("Error: \(error)")
        }
    }
}
