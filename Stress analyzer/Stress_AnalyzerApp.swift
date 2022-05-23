//
//  Stress_AnalyzerApp.swift
//  Stress Analyzer
//
//  Created by Shawn Long on 5/4/22.
//

import SwiftUI

@main
struct Stress_AnalyzerApp: App {
    // IGNORE THE WARNING ABOUT MAIN ACTOR, IT'S A SWIFT BUG
    @StateObject private var surveyResponseData = SurveyResponseViewModel()
    @StateObject private var surveyViewModel = SurveyViewModel()
    @StateObject private var analyticsViewModel = AnalyticsViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(surveyResponseData)
                .environmentObject(surveyViewModel)
                .environmentObject(analyticsViewModel)
        }
    }
}
