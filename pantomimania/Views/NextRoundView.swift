//
//  NextRoundView.swift
//  pantomimania
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
//            Text("\(game.nextRound)ª rodada!")
//                .font(.system(size: fontSize * 3))
//                .fontWeight(.bold)
//                .padding(.top, 32)
            TitleAndSubtitleView(
                title: "Começou a \(game.nextRound)ª rodada!",
                subtitle: "Quem será o primeiro a performar?"
            )
            .padding()
            Spacer()
            RouletteView(
                colors: playerColors, selectedColor: game.playerQueue.first!.color
            )
            Spacer()
//            Spacer()
//            HStack{
//                Image("Images/characters/blue/blueMon")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .padding(-32)
//                Image("Images/characters/yellow/yellowMon")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .padding(-32)
//                Image("Images/characters/pink/pinkMon")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .padding(-32)
//                Image("Images/characters/orange/orangeMon")
//                    .resizable()
//                    .aspectRatio(1/1, contentMode: .fit)
//                    .padding(-32)
//            }
//            .padding(-64)
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
//                Button3D(text: "Continuar", disableMode: .none) {
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
