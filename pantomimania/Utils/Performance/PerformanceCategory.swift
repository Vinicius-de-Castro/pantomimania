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
