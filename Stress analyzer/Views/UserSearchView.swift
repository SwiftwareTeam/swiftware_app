//
//  UserSearchView.swift
//  Stress Analyzer
//
//  Created by Shawn Long on 5/4/22.
//

import SwiftUI

struct UserSearchView: View {
    @EnvironmentObject var surveyResponseData: SurveyResponseViewModel

    @State private var searchText = ""

    var body: some View {
        NavigationView {
            List {
                ForEach(searchResults, id: \.self) { user in
                    NavigationLink(user, destination: Text(user))
                }
            }
            .navigationTitle("Users")
            .searchable(text: $searchText)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .task {
            await surveyResponseData.getUsers()
        }
    }

    var searchResults: [String] {
        if searchText.isEmpty {
            return surveyResponseData.users
        } else {
            return surveyResponseData.users.filter({$0.contains(searchText)})
        }
    }
}

struct UserSearch_Previews: PreviewProvider {
    static var previews: some View {
        UserSearchView()
            .environmentObject(SurveyResponseViewModel())
    }
}
