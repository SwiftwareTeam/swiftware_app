//
//  PersonalityView.swift
//  Stress analyzer
//
//  Created by Shawn Long on 5/9/22.
//

import SwiftUI

struct PersonalityView: View {
    @State private var user: String = "u00"
    @EnvironmentObject var surveyResponseViewModel: SurveyResponseViewModel
    @EnvironmentObject var analyticsViewModel: AnalyticsViewModel

    var body: some View {
        VStack {
            Text("Select a User: ").bold().font(.title)
            Picker("Select a User", selection: $user) {
                ForEach(surveyResponseViewModel.users, id: \.self) { user in
                    Text(user)
                }
            }
            .pickerStyle(.wheel)
            .onChange(of: user) { user in
                Task { await analyticsViewModel.personalityScore(for: user) }
            }

            List(Array(zip(analyticsViewModel.personalityScores[user]?.categories ?? [String](),
                           analyticsViewModel.personalityScores[user]?.scores.map { String(format: "%.0f %%", $0*100.0) } ??  [String]())), id: \.self.0) { (category, score) in
                HStack {
                    Text(category).bold()
                    Spacer()
                    Text(score)
                }
            }
        }.task {
            await analyticsViewModel.personalityScore(for: user)
            await surveyResponseViewModel.getUsers()
        }
    }
}

struct PersonalityView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalityView()
        .environmentObject(AnalyticsViewModel())
        .environmentObject(SurveyResponseViewModel())
    }
}

