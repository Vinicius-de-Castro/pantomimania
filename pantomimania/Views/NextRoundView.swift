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
    
    var body: some View {
        VStack {
            Spacer()
            Text("\(game.nextRound)ª rodada!")
                .font(.system(size: 160))
                .fontWeight(.bold)
            Spacer()
            HStack{
                Image("Images/characters/blue/blueMon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(-32)
                Image("Images/characters/yellow/yellowMon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(-32)
                Image("Images/characters/pink/pinkMon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(-32)
                Image("Images/characters/orange/orangeMon")
                    .resizable()
                    .aspectRatio(1/1, contentMode: .fit)
                    .padding(-32)
            }
            .padding(-64)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationBarBackButtonHidden(true)
        .overlay(alignment: .top) {
            HStack{
                if game.nextRound == 1 {
                    RoundButton3D(systemImage: "chevron.backward", action: {
                        nav.back()
                    }
                    )
                }
                
                Spacer()
                
                Button3D(text: "Continuar", disableMode: .none) {
                    nav.navigate(to: .playerTurn)
                }
            }
            .padding(.horizontal, 24)
            .padding(.top, 16)
        }
    }
}
#Preview {
    NextRoundView()
        .environment(NavManager())
        .environment(GameState())
}
