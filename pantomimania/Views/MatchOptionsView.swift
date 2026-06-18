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
    
    @State private var roundCount: Int = 1
    
    @State private var roundLength: Int = 20
    
    @State private var selectedCategories: [PerformanceCategory] = []
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Configurações da Partida")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(8)
                
                VStack(alignment: .leading) {
                    Text("Quantidades de rodadas")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(Color("Colors/text/primary"))
                    Text("Quantas rodadas terá? (Máx: 5)")
                        .foregroundStyle(Color("Colors/text/primary"))
                    HStack{
                        RoundButton3D(systemImage: "minus", disableMode: (roundCount <= 1 ? .disabled : .none)) {
                            if roundCount > 1 {
                                roundCount -= 1
                            }
                        } holdAction: {}
                        
                        Spacer()
                        
                        Text("\(roundCount)")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        Spacer()
                        RoundButton3D(systemImage: "plus", disableMode: (roundCount >= 5 ? .disabled : .none)) {
                            if roundCount < 5 {
                                roundCount += 1
                            }
                        } holdAction: {}
                        
                    }
                    .padding()
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
                    Text("Duração da Rodada")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(Color("Colors/text/primary"))
                    Text("Quanto tempo deve durar cada rodada para performar a mímica? (Máx: 60s)")
                        .foregroundStyle(Color("Colors/text/primary"))
                    HStack{
                        RoundButton3D(systemImage: "minus", disableMode: (roundLength <= 20 ? .disabled : .none)) {
                            if roundLength > 0 {
                                roundLength -= 1
                            }
                        } holdAction: {
                            if roundLength > 0 {
                                roundLength -= 1
                            }
                        }
                        
                        Spacer()
                        
                        Text("\(roundLength/60):\(String(format:"%02d", roundLength%60))")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        Spacer()
                        RoundButton3D(systemImage: "plus", disableMode: (roundLength >= 60 ? .disabled : .none)) {
                            if roundLength < 60 {
                                roundLength += 1
                            }
                        } holdAction: {
                            if roundLength < 60 {
                                roundLength += 1
                            }
                        }
                        
                    }
                    .padding()
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
                            let isSelected = selectedCategories.contains(cat)
                            Button3D(
                                text: cat.name,
                                systemImage: cat.label,
                                disableMode: isSelected ? .none : .visually,
                                width: .infinity,
                                height: .infinity
                            ) {
                                    if isSelected {
                                        if selectedCategories.count > 1 {
                                            selectedCategories.removeAll(where: { $0 == cat})
                                        }
                                    }
                                    else {
                                        selectedCategories.append(cat)
                                    }
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .padding(4)
                        }
                    }
                    .padding(.top)
                }
                .padding(32)
                .background(Color("Colors/background/bg2"))
                .clipShape(RoundedRectangle(cornerRadius: 28))
                .overlay(
                    RoundedRectangle(cornerRadius: 28)
                        .stroke(Color("Colors/background/border"), lineWidth: 4)
                )
                .padding(.vertical)
                
                
            }
            .padding(128)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationBarBackButtonHidden(true)
            .overlay(alignment: .top) {
                HStack{
                    RoundButton3D(systemImage: "chevron.backward", action: {
                        nav.back()
                    }
                    )
                    
                    Spacer()
                    
                    Button3D(text: "Jogar", disableMode: (selectedCategories.isEmpty ? .disabled : .none)) {
                        game.roundCount = roundCount
                        game.roundLength = roundLength
                        game.selectedCategories = selectedCategories
                        game.playerQueue = game.playerList.shuffled()
                        nav.navigate(to: .nextRound)
                    }
                }
                .padding(.horizontal, 24)
                .padding(.top, 16)
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
