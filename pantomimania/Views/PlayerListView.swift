//
//  PlayerListView.swift
//  pantomimania
//
//  Created by Vinicius Rodrigues de Castro on 03/06/26.
//

import SwiftUI

struct PlayerListView: View {
    
    @Environment(NavManager.self) var nav
    @Environment(GameState.self) var game
    
    @State var playerList: [Player] = []
    
    var body: some View {
        VStack (alignment: .center){
            Text("Adicione os jogadores")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(50)
            HStack {
                ForEach(playerList) { player in
                    @Bindable var bindablePlayer = player
                    VStack (alignment: .center){
                        RoundedRectangle(cornerRadius: 16)
                            .foregroundStyle(Color.accentColor)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(.black, lineWidth: 4)
                            )
                        TextField("Nome", text: $bindablePlayer.name)
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(.black, lineWidth: 4)
                            )
                    }
                    
                    .containerRelativeFrame(.horizontal, count: 5, spacing: 64)
                    .containerRelativeFrame(.vertical, count: 2, spacing: 64)
                }
                
                if (playerList.count < 4) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .containerRelativeFrame(.horizontal, count: 5, spacing: 64)
                            .containerRelativeFrame(.vertical, count: 2, spacing: 64)
                            .foregroundStyle(.gray)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(.black, lineWidth: 4)
                            )
                        VStack {
                            Text("Adicionar jogador")
                                .font(.title3)
                                .fontWeight(.bold)
                                .padding(.vertical)
                                .multilineTextAlignment(.center)
                                .containerRelativeFrame(.horizontal, count: 8, spacing: 64)
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .aspectRatio(1/1, contentMode: .fit)
                                .containerRelativeFrame(.horizontal, count: 8, spacing: 64)
                                .foregroundStyle(.blue)
                                .background(
                                    Circle()
                                        .fill(Color.white)
                                )
                                .overlay(
                                    Circle()
                                        .stroke(.black, lineWidth: 4)
                                )
                        }
                    }
                    .onTapGesture {
                        playerList.append(Player(name: "Jogador \(playerList.count + 1)"))
                    }
                }
            }
        }
        .toolbar {
            Button("Jogar") {
                game.playerList = playerList
                nav.navigate(to: .matchOptions)
            }
            .disabled(playerList.count < 2 || playerList.contains(where: { $0.name.isEmpty }))
        }
    }
}

#Preview {
    PlayerListView()
        .environment(NavManager())
        .environment(GameState())
}
