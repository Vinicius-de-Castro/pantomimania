//
//  MatchOptionsView.swift
//  pantomimania
//
//  Created by Vinicius Rodrigues de Castro on 03/06/26.
//

import SwiftUI

struct MatchOptionsView: View {
    
    @Environment(NavManager.self) var nav
    
    var body: some View {
        VStack{
            Text("Configure a partida")
            Button("Jogar") {
                nav.navigate(to: .playerTurn)
            }
        }
    }
}
