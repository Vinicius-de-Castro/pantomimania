//
//  Performance.swift
//  pantomimania
//
//  Created by Vinicius Rodrigues de Castro on 08/06/26.
//
import SwiftUI

enum Difficulty: String {
    case easy, medium, hard
}

class Performance: Identifiable, Codable {
    var id = UUID()
    var name: String
    var description: String
    
    init(name: String, description: String) {
        self.name = name
        self.description = description
    }
    
    enum CodingKeys: String, CodingKey {
        case name, description
    }
}
