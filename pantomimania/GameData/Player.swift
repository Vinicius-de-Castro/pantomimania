//
//  Player.swift
//  pantomimania
//
//  Created by Vinicius Rodrigues de Castro on 08/06/26.
//

import SwiftUI

@Observable
class Player: Identifiable {
    var id = UUID()
    var name: String
    var mascot: Image?
    var color: Color = .blue
    
    init(name: String, mascot: Image? = nil, color: Color) {
        self.name = name
        self.mascot = mascot
        self.color = color
    }
}
