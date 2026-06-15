//
//  PerformanceCategory.swift
//  pantomimania
//
//  Created by Vinicius Rodrigues de Castro on 08/06/26.
//

import Foundation

class PerformanceCategory: Identifiable, Codable {
    var id = UUID()
    let name: String
    let performances: [Performance]
    
    enum CodingKeys: String, CodingKey {
        case name
        case performances
    }
}

extension PerformanceCategory: Equatable{
    static func == (lhs: PerformanceCategory, rhs: PerformanceCategory) -> Bool {
        return {
            lhs.id == rhs.id &&
            lhs.name == rhs.name
        }()
    }
}
