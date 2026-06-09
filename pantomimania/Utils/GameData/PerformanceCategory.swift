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
    let easyPerformances: [Performance]
    let normalPerformances: [Performance]
    let hardPerformances: [Performance]
    
    enum CodingKeys: String, CodingKey {
        case name
        case easyPerformances
        case normalPerformances
        case hardPerformances
    }
}

extension PerformanceCategory: Equatable{
    static func == (lhs: PerformanceCategory, rhs: PerformanceCategory) -> Bool {
        return {
            lhs.id == rhs.id &&
            lhs.name == rhs.name &&
            NSOrderedSet(array: lhs.easyPerformances).isEqual(to: NSOrderedSet(array: rhs.easyPerformances)) &&
            NSOrderedSet(array: lhs.normalPerformances).isEqual(to: NSOrderedSet(array: rhs.normalPerformances)) &&
            NSOrderedSet(array: lhs.hardPerformances).isEqual(to: NSOrderedSet(array: rhs.hardPerformances))
        }()
    }
}
