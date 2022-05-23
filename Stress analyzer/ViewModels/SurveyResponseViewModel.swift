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
    @Published var surveyResponses : [UUID : SurveyResponse]
    @Published var users: [String]
    @Published var surveyResp: [SurveyResponse]
    let baseURL = "http://swiftware.tech"

    init() {
        // New class properties should be initialized in here
        self.users = [String]()
        self.surveyResponses = [UUID : SurveyResponse]()
        self.surveyResp = [SurveyResponse]()
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

    // TODO: Implement Function
    // Adjust function arguments as needed
    func loadResponses(uid: String) async {
        let url = URL(string: baseURL + "/getResponses/" + uid)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            surveyResp = try JSONDecoder().decode([SurveyResponse].self, from: data)
            
        } catch {
            print("unable to retrieve users from server. Reason: \(error)")
        }
        
    }
    

    
    func createResponse(surveyResp: SurveyResponse) async {
        guard let url = URL(string: baseURL + "/createResponse") else {
                print("Error: cannot create URL")
                return
        }
        //make post request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        do{
            guard let surveyRespData = try? JSONEncoder().encode(surveyResp) else{
                print ("Error trying to encode Survey Response")
                return
            }

            let (_, response) = try await URLSession.shared.upload(for: request, from: surveyRespData )

            guard let httpResponse = response as? HTTPURLResponse, (200) <= httpResponse.statusCode else {
                print("Error: Unable to decode the HTTP Response ")
                return
            }
            print ("http response: " , httpResponse) //prints out response
        }
        catch{
            print("Error")
        }
    }


    func deleteResponse(surveyResp: SurveyResponse) async {
        guard let url = URL(string: baseURL + "/deleteResponse") else {
                print("Error: cannot create URL")
                return
        }
        // Create the delete request
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        do{
            guard let surveyRespData = try? JSONEncoder().encode(surveyResp) else{
                print ("Error trying to encode Survey Response")
                return
            }

            let (_, response) = try await URLSession.shared.upload(for: request, from: surveyRespData )

            guard let httpResponse = response as? HTTPURLResponse, (200) <= httpResponse.statusCode else {
                print("Error: Unable to decode the HTTP Response ")
                return
            }
            print ("http response: " , httpResponse) //prints out response
        }
        catch{
            print("Error")
        }
    }

    // TODO: Implement Function
    // Adjust function arguments as needed
    func updateResponse(id: UUID) async {
        guard let url = URL(string: baseURL + "/updateResponse") else {
                print("Error: cannot create URL")
                return
        }
        // Create the update request
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        do{
            guard let surveyRespData = try? JSONEncoder().encode(surveyResp) else{
                print ("Error trying to encode Survey Response")
                return
            }

            let (_, response) = try await URLSession.shared.upload(for: request, from: surveyRespData )

            guard let httpResponse = response as? HTTPURLResponse, (200) <= httpResponse.statusCode else {
                print("Error: Unable to decode the HTTP Response ")
                return
            }
            print ("http response: " , httpResponse) //prints out response
        }
        catch{
            print("Error")
        }
    }

    // TODO: Implement Function
    func performBackup() async {

    }

    // TODO: Implement Function
    func loadBackup() async {

    }
}
