//
//  ContentView.swift
//  Stress Analyzer
//
//  Created by Shawn Long on 5/4/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var surveyViewModel: SurveyViewModel
    @EnvironmentObject var surveyResponseViewModel: SurveyResponseViewModel
    @EnvironmentObject var anlayticsViewModel: AnalyticsViewModel
    
    var body: some View {
        TabView {
            UserSearchView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Individual Statistics")
                }
            Text("Group Stats Go Here")
                .tabItem {
                    Image(systemName: "person.3.fill")
                    Text("Group Statistics")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(SurveyResponseViewModel())
            .environmentObject(SurveyViewModel())
            .environmentObject(AnalyticsViewModel())
    }
}
