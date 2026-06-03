//
//  PlayerTurnView.swift
//  pantomimania
//
//  Created by Vinicius Rodrigues de Castro on 03/06/26.
//

import SwiftUI

struct PlayerTurnView: View {
    
    @Environment(NavManager.self) var nav
    
    var body: some View {
        VStack {
            Text("Vez do fulano")
            Text("Passe o dispositivo")
            Button("Performar") {
                nav.navigate(to: .promptSelection)
            }
        }
    }
}
