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
            Text("Adicione 2 a 4 jogadores")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(50)
            HStack {
                ForEach(playerList) { player in
                    @Bindable var bindablePlayer = player
                    VStack (alignment: .center){
                        RoundedRectangle(cornerRadius: 16)
                            .foregroundStyle(Color.accentColor)
                        TextField("Nome", text: $bindablePlayer.name)
                            .padding()
                            .overlay{
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(.quaternary, lineWidth: 2)
                            }
                    }
                    
                    .containerRelativeFrame(.horizontal, count: 5, spacing: 64)
                    .containerRelativeFrame(.vertical, count: 2, spacing: 64)
                }
                
                if (playerList.count < 4) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .containerRelativeFrame(.horizontal, count: 5, spacing: 64)
                            .containerRelativeFrame(.vertical, count: 2, spacing: 64)
                            .foregroundStyle(.quaternary)
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
                        }
                    }
                    .onTapGesture {
                        playerList.append(Player(name: "Jogador \(playerList.count + 1)"))
                    }
                }
            }
        }
        .toolbar {
            Button("Continuar") {
                game.playerList = playerList
                nav.navigate(to: .matchOptions)
            }
            .disabled(playerList.count < 2 || playerList.contains(where: { $0.name.isEmpty }))
            .buttonStyle(.borderedProminent)
            .foregroundStyle(Color.primary)
            .tint(Color.accentColor)
        }
        .navigationTitle("Lista de jogadores")
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    PlayerListView()
        .environment(NavManager())
        .environment(GameState())
}
