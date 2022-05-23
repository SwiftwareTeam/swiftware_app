//
//  UserSearchView.swift
//  Stress Analyzer
//
//  Created by Shawn Long on 5/4/22.
//

import SwiftUI

struct TextFieldAlert<Presenting>: View where Presenting: View {

    @Binding var isShowing: Bool
    @Binding var text: String
    let presenting: Presenting
    let title: String

    var body: some View {
        GeometryReader { (deviceSize: GeometryProxy) in
            ZStack {
                self.presenting
                    .disabled(isShowing)
                VStack {
                    Text(self.title)
                    TextField(title, text: self.$text)
                    Divider()
                    HStack {
                        Button(action: {
                            withAnimation {
                                self.isShowing.toggle()
                                
                            }
                        }) {
                            Text("Done").foregroundColor(.blue)
                        }
                    }
                }
                .padding()
                .background(Color(red: 0.6843137255, green: 0.6176470588, blue: 1))
                .cornerRadius(11)
                .frame(
                    width: deviceSize.size.width*0.7,
                    height: deviceSize.size.height*0.7
                )
                .shadow(radius: 1)
                .opacity(self.isShowing ? 1 : 0)
            }
        }
    }

}
/// Global variable used for the max number of results in the list view
let listMaxDisplayCount = 50

struct UserSearchView: View {
    @State var isAlert = false
    @EnvironmentObject var surveyResponseData: SurveyResponseViewModel
    @State private var searchText = ""
    @State private var isShowingAlert = false
    @State private var newInput = ""
    @State private var deleteMode = false
    
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
                        if deleteMode {
                            Button {
                                deleteUser(name: user)
                                deleteMode.toggle()
                            } label: {
                                Text(user).foregroundColor(.black)
                            }
                            Spacer()
                            Image(systemName: "person.crop.circle")
                            Image(systemName: "minus.circle.fill").foregroundColor(.red)
                        } else {
                            NavigationLink(user, destination: SurveyView(currUser: user))
                            Spacer()
                            Image(systemName: "person.crop.circle")
                        }
                    }
                }
            }
            .toolbar {
                HStack{
                    Button {
                        Task { await surveyResponseData.performBackup() }
                    } label: {
                        Image(systemName: "clock.arrow.circlepath")
                            .foregroundColor(.white)
                            .font(.title2)
                    }

                    Button {
                        Task { await surveyResponseData.loadBackup() }
                    } label: {
                        Image(systemName: "arrowshape.turn.up.right")
                            .foregroundColor(.white)
                            .font(.title2)
                    }

                    Button {
                        //addNullUser(name: "newguy")
                        self.isShowingAlert.toggle()
                    } label: {
                        Image(systemName: "person.badge.plus").foregroundColor(.white)
                            .font(.title2)
                    }
                    Button {
                        deleteMode.toggle()
                    } label: {
                        Image(systemName: "trash").foregroundColor(.white)
                            .font(.title2)
                    }
                }
            }
            
            .navigationTitle("Users")
            .searchable(text: $searchText)
        }
        .textFieldAlert(isShowing: $isShowingAlert, text: $newInput, title: "New User")
        .navigationViewStyle(StackNavigationViewStyle())
        
        .onChange(of: isShowingAlert) { whatever in
            if(!isShowingAlert && newInput != "") {
                addNullUser(name: newInput)
                print("New user added")
            }
            
        }
        
        .task {
            await surveyResponseData.getUsers()
        }
    }

    var searchResults: [String] {
        if searchText.isEmpty {
            if surveyResponseData.users.count > listMaxDisplayCount {
                let firstFifty = surveyResponseData.users[..<listMaxDisplayCount]
                return Array<String>(firstFifty)
            }
            return surveyResponseData.users
        } else {
            let filtered_array = surveyResponseData.users.filter({$0.contains(searchText)})
            if filtered_array.count > listMaxDisplayCount {
                let firstFifty = filtered_array[..<listMaxDisplayCount]
                return Array<String>(firstFifty)
            }
            return filtered_array
        }
    }
    
    func addNullUser(name: String) {
        surveyResponseData.addNewResponse(forUser: name)
    }
    func deleteUser(name: String) {
        surveyResponseData.removeResponses(forUser: name)
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
                
                if surveyResponseData.surveyResponses.count > 0 {
                    
                    Text(surveyResponseData.surveyResponses[0].uid)
                        .font(.largeTitle)

                    var number = (surveyResponseData.surveyResponses[0].responses[index] ?? 0) ?? 0

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
        surveyResponseData.surveyResponses[0].responses[index] = nil
        var responseToUpdate = surveyResponseData.surveyResponses[0]
        responseToUpdate.responses[index] = nil as Int?
        responseToUpdate.id = surveyResponseData.surveyResponses[0].id
        surveyResponseData.updateExistingResponse(responseToUpdate)
    }
    func editResponse(num: Int) {
        var responseToUpdate = surveyResponseData.surveyResponses[0]
        responseToUpdate.responses[index] = num
        responseToUpdate.id = surveyResponseData.surveyResponses[0].id
        surveyResponseData.updateExistingResponse(responseToUpdate)

    }
    func loadCnt() {
        respCount = surveyResponseData.surveyResponses.count
    }
}

struct UserSearch_Previews: PreviewProvider {
    static var previews: some View {
        UserSearchView()
            .environmentObject(SurveyResponseViewModel())
            .environmentObject(SurveyViewModel())
    }
}
extension View {

    func textFieldAlert(isShowing: Binding<Bool>,
                        text: Binding<String>,
                        title: String) -> some View {
        TextFieldAlert(isShowing: isShowing,
                       text: text,
                       presenting: self,
                       title: title)
    }

}
