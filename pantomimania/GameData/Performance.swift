//
//  Performance.swift
//  Panto Party
//
//  Created by Vinicius Rodrigues de Castro on 08/06/26.
//
import SwiftUI

enum Difficulty: String, Codable {
    case easy, medium, hard
}

class Performance: Identifiable, Codable {
    var id = UUID()
    var name: String
    var description: String
    let difficulty: Difficulty
    
    init(name: String, description: String, difficulty: Difficulty) {
        self.name = name
        self.description = description
        self.difficulty = difficulty
    }
    
    enum CodingKeys: String, CodingKey {
        case name, description, difficulty
    }
}
