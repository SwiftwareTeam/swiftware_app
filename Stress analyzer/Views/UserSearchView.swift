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
    
    init() {
        UITableView.appearance().backgroundColor = UIColor(red: 0.5843137255, green: 0.5176470588, blue: 1, alpha: 1)
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = UIColor.white
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = UIColor.black
        UINavigationBar.appearance().tintColor = UIColor.systemBlue
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(searchResults, id: \.self) { user in
                    HStack {
                        NavigationLink(user, destination: Text(user))
                        Spacer()
                        Image(systemName: "person.crop.circle")
                    }
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


