//
//  Performance.swift
//  pantomimania
//
//  Created by Vinicius Rodrigues de Castro on 08/06/26.
//
import SwiftUI

enum Difficulty: String {
    case easy, normal, hard
}

class Performance: Identifiable, Codable {
    var id = UUID()
    var name: String
    var description: String
    var photo: String
    
    init(name: String, description: String, photo: String) {
        self.name = name
        self.description = description
        self.photo = photo
    }
    
    enum CodingKeys: String, CodingKey {
        case name, description, photo
    }
}
