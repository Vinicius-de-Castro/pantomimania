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
        
        let imageMon =
        switch game.playerQueue.first!.mascot {
        case Image("Images/characters/blue/blueCard"):
            Image("Images/characters/blue/blueMon")
                .resizable()
            
        case Image("Images/characters/yellow/yellowCard"):
            Image("Images/characters/yellow/yellowMon")
                .resizable()
            
        case Image("Images/characters/pink/pinkCard"):
            Image("Images/characters/pink/pinkMon")
                .resizable()
            
        case Image("Images/characters/orange/orangeCard"):
            Image("Images/characters/orange/orangeMon")
                .resizable()
            
        default:
            Image("Images/characters/blue/blueMon")
                .resizable()
        }

        
        VStack {
            TitleAndSubtitleView(title: "Vez de \(game.playerQueue.first!.name)!", subtitle: "Passe o dispositivo para o jogador da vez")
            
            Spacer()
            
            imageMon
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(64)
                .padding(.bottom, -200)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(alignment: .topTrailing) {
            Button3D(text: "Continuar") {
                nav.navigate(to: .promptSelection)
            }
            .padding(.trailing, 24)
            .padding(.top, 16)
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    PlayerTurnView()
        .environment(NavManager())
        .environment(GameState())
}
