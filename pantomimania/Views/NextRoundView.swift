//
//  NextRoundView.swift
//  Panto Party
//
//  Created by Vinicius Rodrigues de Castro on 17/06/26.
//

import SwiftUI

struct NextRoundView: View {
    
    @Environment(NavManager.self) var nav
    
    @Environment(GameState.self) var game
    
    @ScaledMetric var fontSize: CGFloat = 24
    
    var body: some View {
        
        let playerColors = game.playerList.map({$0.color})
        
        VStack {
            
            PantoTopBar(
                title: "Começou a \(game.nextRound)ª rodada!",
                subtitle: "Quem será o primeiro a performar?"
            )
            .padding()
            Spacer()
            RouletteView(
                colors: playerColors, selectedColor: game.playerQueue.first!.color
            )
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                nav.navigate(to: .playerTurn)
            }
        }
//        .overlay(alignment: .topLeading) {
//            HStack{
//                if game.nextRound == 1 {
//                    RoundButton3D(systemImage: "chevron.backward", action: {
//                        nav.back()
//                    }
//                    )
//                }
                
//                Spacer()
//                
//                Button3D(text: "Continuar", DisableMode: .none) {
//                    nav.navigate(to: .playerTurn)
//                }
//            }
//            .padding(.horizontal, 24)
//            .padding(.top, 16)
//        }
    }
}
#Preview {
    NextRoundView()
        .environment(NavManager())
        .environment(GameState())
}
