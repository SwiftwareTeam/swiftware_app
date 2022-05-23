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
    @Published var surveyResponses: [SurveyResponse]
//    let baseURL = "http://swiftware.tech"
    let baseURL = "http://127.0.0.1:8080"

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
        let url = URL(string: baseURL + "/getResponses/" + uid)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            surveyResponses = try JSONDecoder().decode([SurveyResponse].self, from: data)

            guard let httpResponse = response as? HTTPURLResponse, (200) <= httpResponse.statusCode else {
                print("Error: Unable to decode the HTTP Response ")
                return
            }
            print("(GET) Load Response Status Code: \(httpResponse.statusCode)")
            
        } catch {
            print("unable to retrieve users from server. Reason: \(error)")
        }
        
    }
    
    func createResponse(_ surveyResp: SurveyResponse) async {
        print("INFO : Creating Survey Response for \(surveyResp.id)")
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
            print("(POST) Status Code: \(httpResponse.statusCode)")
        }
        catch{
            print("Error")
        }
    }


    func deleteResponse(_ surveyResp: SurveyResponse) async {
        print("INFO : Deleting Survey Response \(surveyResp.id)")
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
            print("(DELETE) Status Code: \(httpResponse.statusCode)")
        }
        catch{
            print("Error")
        }
    }

    func updateResponse(_ surveyResp: SurveyResponse) async {
        print("INFO : Updating response for user \(surveyResp.uid)")
        guard let url = URL(string: baseURL + "/updateResponse") else {
                print("Error: cannot create URL")
                return
        }
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
            print("(PATCH) Status Code: \(httpResponse.statusCode)")
        }
        catch{
            print("Error")
        }
    }

    func performBackup() async {
        print("INFO : Initiated Request to Perform Backup")
        guard let url = URL(string: baseURL + "/backup") else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        do {
            let (_, response) = try await URLSession.shared.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse, (200) <= httpResponse.statusCode else {
                print("Error: Unable to decode the HTTP Response ")
                return
            }
            print("(GET) Backup Status Code: \(httpResponse.statusCode)")
        } catch {
            print("unable to perform server backup. Reason: \(error)")
        }
    }

    func loadBackup() async {
        print("INFO : Initiated Request to Load Backup")
        guard let url = URL(string: baseURL + "/loadBackup") else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        do {
            let (_, response) = try await URLSession.shared.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse, (200) <= httpResponse.statusCode else {
                print("Error: Unable to decode the HTTP Response ")
                return
            }
            print("(GET) Load-Backup Status Code: \(httpResponse.statusCode)")
        } catch {
            print("unable to perform server backup. Reason: \(error)")
        }

    }

    func removeResponses(forUser user: String) {
        let userResponses = self.surveyResponses.filter { $0.uid == user }

        print("Removing responses for user \(user)")

        var loaded = false
        for response in userResponses {
            print("Executing Asyncronous Task: Delete \(response.id)")
            Task(priority: .userInitiated) {
                if !loaded {
                    await self.loadResponses(uid: user)
                    loaded = true
                }
                await self.deleteResponse(response)

            }
        }

        self.surveyResponses = surveyResponses.filter { $0.uid != user }
        self.users = users.filter { $0 != user }
    }

    func addNewResponse(forUser user: String) {
        let responses = Dictionary<Int, Int?>(uniqueKeysWithValues: Array<Int>(1...44).map { ($0, nil)})

        let surveyResponse = SurveyResponse(uid: user,
                                            surveyID: 1,
                                            responseType: "post",
                                            responses: responses)

        Task(priority: .userInitiated) {
            print("Executing Asyncronous Task: Create \(surveyResponse.id)")
            await self.createResponse(surveyResponse)

        }

        self.surveyResponses.append(surveyResponse)

        if !self.users.contains(user) {
            self.users.append(user)
        }
    }

    func updateExistingResponse(_ response: SurveyResponse) {
        if let index = self.surveyResponses.firstIndex(where: { $0.id == response.id }) {
            self.surveyResponses[index] = response
            Task(priority: .userInitiated) {
                print("Executing Asyncronous Task: Update \(response.id)")
                await self.updateResponse(response)

            }
        }
    }
}
