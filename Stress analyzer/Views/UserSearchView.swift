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
                        NavigationLink(user, destination: SurveyView(currUser: user))
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

struct SurveyView: View {
    var currUser: String
    @EnvironmentObject var surveyResponseData: SurveyResponseViewModel
    @EnvironmentObject var survey: SurveyViewModel
    
    @State private var index = 1
    @State private var respCount = 0
    
    
    @State private var showSelection = false
    
    var body: some View {
        NavigationView {
            VStack{
                HStack {
                    Spacer().frame(width: 50)
                    Button {
                        traversePrev()
                    } label: {
                        Image(systemName: "arrow.left.circle.fill")
                            .imageScale(.large)
                            .foregroundColor(Color(.blue))
                    }
                    Spacer()
                    
                    Button {
                        traverseNext()
                    } label: {
                        Image(systemName: "arrow.right.circle.fill")
                            .imageScale(.large)
                            .foregroundColor(Color(.blue))
                    }
                    Spacer().frame(width: 50)
                    
                }.frame(height: 100)
                
                
                
                if surveyResponseData.surveyResp.count > 0 {
                    
                    Text(surveyResponseData.surveyResp[0].uid)
                        .font(.largeTitle)

                    var number = (surveyResponseData.surveyResp[0].responses[index] ?? 0) ?? 0

                    if survey.surveys.count > 0 {
                        Spacer()
                        Text(survey.surveys[1]?.questions[index]?.fullWording ?? "--")
                        Spacer().frame(height: 50)
                        if number == 0 {
                            Text("No Answer")
                            
                        } else {
                            Text(survey.surveys[1]?.answers[number]?.label ?? "--")
                        }
                    }
                }

                Spacer()
                HStack{
                    Spacer()
                    if showSelection { // New answer buttons
                        Button {
                            showSelection.toggle()
                            editResponse(num: 1)
                        } label: {
                            Text(" DS").foregroundColor(Color(.black))
                        }
                        Button {
                            showSelection.toggle()
                            editResponse(num: 2)
                        } label: {
                            Text(" D").foregroundColor(Color(.black))
                        }
                        Button {
                            showSelection.toggle()
                            editResponse(num: 3)
                        } label: {
                            Text(" N").foregroundColor(Color(.black))
                        }
                        Button {
                            showSelection.toggle()
                            editResponse(num: 4)
                        } label: {
                            Text(" A").foregroundColor(Color(.black))
                        }
                        Button {
                            showSelection.toggle()
                            editResponse(num: 5)
                        } label: {
                            Text(" AS").foregroundColor(Color(.black))
                        }
                    }
                    Button {
                        showSelection.toggle()
                    } label: {
                        Image(systemName: "rectangle.badge.plus")
                            .imageScale(.large)
                            .frame(width: 50, height: 50, alignment: .trailing)
                            .foregroundColor(Color(.blue))
                    }
                    Button {
                        clearResponse()
                    } label: {
                        Image(systemName: "trash")
                            .imageScale(.large)
                            .frame(width: 50, height: 50, alignment: .trailing)
                            .foregroundColor(Color(.blue))
                    }
                }
                
                //Spacer().frame(height: 22)

            }
        }
        .task {
            await surveyResponseData.getUsers()
            await surveyResponseData.loadResponses(uid: currUser)
            await survey.getSurveys()
        }
    }
    func traverseNext() {
        index+=1
    }
    func traversePrev() {
        if index > 1 {
            index-=1
            //currUser = surveyResponseData.users[index]
        }
    }
    func clearResponse() {
        surveyResponseData.surveyResp[0].responses[index] = nil
        //api call
    }
    func editResponse(num: Int) {
        surveyResponseData.surveyResp[0].responses[index] = num
    }
    func loadCnt() {
        respCount = surveyResponseData.surveyResp.count
    }
}

struct UserSearch_Previews: PreviewProvider {
    static var previews: some View {
        UserSearchView()
            .environmentObject(SurveyResponseViewModel())
            .environmentObject(SurveyViewModel())
    }
}
