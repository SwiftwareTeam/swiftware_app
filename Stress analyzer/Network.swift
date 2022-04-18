//
//  Network.swift
//  Stress analyzer
//
//  Created by Arzhang Valadkhani on 4/18/22.
//

import Foundation
import SwiftUI
class Network:ObservableObject{
    
    
    @Published var users: [User] = []
    func getUser(){
        guard let url = URL(string: "http://swiftware.tech/getResponses/") else { fatalError("Missing URL") }
        
    }
}
