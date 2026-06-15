//
//  MatchOptionsView.swift
//  pantomimania
//
//  Created by Vinicius Rodrigues de Castro on 03/06/26.
//

import SwiftUI

struct MatchOptionsView: View {
    
    @Environment(NavManager.self) var nav
    
    @Environment(GameState.self) var game
    
    @State private var roundLength: Int = 10
    
    @State private var selectedCategories: [PerformanceCategory] = []
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Configurações da Partida")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(8)
                
                VStack(alignment: .leading) {
                    Text("Duração da Rodada")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(Color("Colors/text/primary"))
                    Text("Quanto tempo deve durar cada rodada para performar a mímica? (Máx: 60s)")
                        .foregroundStyle(Color("Colors/text/primary"))
                    HStack{
                        Button {
                            roundLength -= 1
                        } label: {
                            Image(systemName: "minus")
                                .padding(32)
                                .foregroundStyle(.white)
                                .background(.accent)
                                .clipShape(Circle())
                        }
                        .disabled(roundLength == 10)
                        
                        Spacer()
                        
                        Text("\(roundLength/60):\(String(format:"%02d", roundLength%60))")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        Button {
                            roundLength += 1
                        } label: {
                            Image(systemName: "plus")
                                .padding(32)
                                .foregroundStyle(.white)
                                .background(.accent)
                                .clipShape(Circle())
                        }
                        .disabled(roundLength == 60)
                    }
                }
                .padding(32)
                .background(Color("Colors/background/bg2"))
                .clipShape(RoundedRectangle(cornerRadius: 28))
                .overlay(
                    RoundedRectangle(cornerRadius: 28)
                        .stroke(Color("Colors/background/border"), lineWidth: 4)
                )
                .padding(.vertical)
                
                VStack(alignment: .leading) {
                    Text("Categorias")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(Color("Colors/text/primary"))
                    
                    Text("Quais categorias poderão ser perfomadas?")
                        .foregroundStyle(Color("Colors/text/primary"))
                    
                    let columns: [GridItem] = [
                        GridItem(.flexible(minimum: 100)),
                        GridItem(.flexible(minimum: 100)),
                        GridItem(.flexible(minimum: 100))
                    ]
                    
                    LazyVGrid(columns: columns) {
                        ForEach(game.performanceCategories) { cat in
                            Text(cat.name)
                                .font(.title2)
                                .fontWeight(.bold)
                                .padding()
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(
                                    (selectedCategories.contains(cat) ? .accent : Color("Colors/text/secondary"))
                                )
                                .foregroundStyle(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 22))
                                .padding(4)
                                .onTapGesture {
                                    if (selectedCategories.contains(cat) && selectedCategories.count > 1) {
                                        selectedCategories.removeAll(where: { $0 == cat})
                                    }
                                    else {
                                        selectedCategories.append(cat)
                                    }
                                }
                        }
                    }
                }
                .padding(32)
                .background(Color("Colors/background/bg2"))
                .clipShape(RoundedRectangle(cornerRadius: 28))
                .overlay(
                    RoundedRectangle(cornerRadius: 28)
                        .stroke(Color("Colors/background/border"), lineWidth: 4)
                )
                
                
            }
            .padding(128)
//            .navigationTitle(Text("Configurações da Partida"))
            .toolbar{
                Button("Jogar") {
                    game.roundLength = roundLength
                    game.selectedCategories = selectedCategories
                    game.playerQueue = game.playerList.shuffled()
                    nav.navigate(to: .playerTurn)
                }
                .buttonStyle(.borderedProminent)
                .foregroundStyle(Color.primary)
                .tint(Color.accentColor)
                .disabled(selectedCategories.isEmpty)
            }
            .onAppear{
                selectedCategories.append(game.performanceCategories[0])
            }
        }
    }
}
#Preview {
    MatchOptionsView()
        .environment(NavManager())
        .environment(GameState())
}
