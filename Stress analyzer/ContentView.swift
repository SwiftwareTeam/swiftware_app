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
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor(#colorLiteral(red: 0.5843137255, green: 0.5176470588, blue: 1, alpha: 1))
    }
    
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
        }.accentColor(.white)
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
