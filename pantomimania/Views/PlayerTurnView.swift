//
//  PlayerTurnView.swift
//  pantomimania
//
//  Created by Vinicius Rodrigues de Castro on 03/06/26.
//

import SwiftUI

struct PlayerTurnView: View {
    
    @Environment(NavManager.self) var nav
    
    @Environment(GameState.self) var game
    
    var body: some View {
        VStack {
            Text("É a vez de \(game.playerQueue.first!.name)!")
                .font(.largeTitle)
                .bold()
            Text("Passe o dispositivo para o jogador")
            Circle()
                .containerRelativeFrame(.horizontal, count: 3, spacing: 20)
                .foregroundStyle(.blue)
                .blur(radius: 50)
                .padding()
            Button("Continuar") {
                nav.navigate(to: .promptSelection)
            }
            .buttonStyle(.borderedProminent)
            .foregroundStyle(Color.primary)
            .tint(Color.accentColor)
        }
        .navigationBarBackButtonHidden(true)
    }
}
