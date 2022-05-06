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

    init() {
        // New class properties should be initialized in here
        self.surveys = [Survey]()
    }

    // TODO: Implement Function
    func getSurveys() async {

    }
}
