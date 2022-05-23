//
//  SurveyResponseData.swift
//  Stress Analyzer
//
//  Created by Shawn Long on 5/4/22.
//

import Foundation

/**
 This is the View Model containing Survey Response Data retrieved from the server
 */
@MainActor
final class SurveyResponseViewModel: ObservableObject {
    @Published var users: [String]
    @Published var surveyResponses: [SurveyResponse] //holds all of the survey responses
    let baseURL = "http://swiftware.tech"

    init() {
        // New class properties should be initialized in here
        self.users = [String]()
        self.surveyResponses = [SurveyResponse]()
    }

    /**
     Retrieves a list of User Strings from server asynchronously
     and saves the list to the users list
     */
    func getUsers() async {
        guard let url = URL(string: baseURL + "/getUsers") else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        do {
            let (data, _ ) = try await URLSession.shared.data(for: request)
            if let userList = try? JSONDecoder().decode([String].self, from: data) {
                self.users = userList
            }
        } catch {
            print("unable to retrieve users from server. Reason: \(error)")
        }
    }

    func loadResponses(uid: String) async {
        
        print ("inside func")
        let url = URL(string: baseURL + "/getResponses/" + uid)!
        print ("url: " , url)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        

        do {
            print ("inside do task")
            let (data, _) = try await URLSession.shared.data(for: request)
            surveyResponses = try JSONDecoder().decode([SurveyResponse].self, from: data)
        
            //print(surveyResp)
        } catch {
            print("unable to retrieve users from server. Reason: \(error)")
        }
        
    }
    

    // TODO: Implement Function
    // Adjust function arguments as needed
    func createResponse(id: UUID) async {
        
    }

    // TODO: Implement Function
    // Adjust function arguments as needed
    func deleteResponse(id: UUID) async {

    }

    // TODO: Implement Function
    // Adjust function arguments as needed
    func updateResponse(id: UUID) async {

    }

    // TODO: Implement Function
    func performBackup() async {

    }

    // TODO: Implement Function
    func loadBackup() async {

    }
}
