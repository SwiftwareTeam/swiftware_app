//
//  User.swift
//  Stress analyzer
//
//  Created by Arzhang Valadkhani on 4/18/22.
//

import Foundation

struct User: Identifiable, Decodable {
    var id: String?
    
    struct type : Decodable {
        var question = [String: String]()
    
    }
    
    
}
