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
    
    @State private var roundLength: Int = 30
    @State private var selectedCategories: [PerformanceCategory] = []
    
    var body: some View {
        VStack{
//            Text("Configure a partida")
            List{
                Section{
                    Stepper(value: $roundLength, in: 30...90) {
                        VStack(alignment: .leading){
                            Text("Duração da rodada")
                            Text("\(roundLength/60):\(roundLength%60)")
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                .padding(.horizontal)
                Section(){
                    ForEach(game.performanceCategories) { cat in
//                        Picker(cat.name)
                        HStack {
                            Text(cat.name)
                            Spacer()
                            if selectedCategories.contains(cat) {
                                Image(systemName: "plus.circle.fill")
                                    .foregroundStyle(.green)
                                    .scaledToFit()
                            }
                            else {
                                Image(systemName: "plus.circle")
                                    .foregroundStyle(.tertiary)
                                    .scaledToFit()
                            }
                        }
                        .onTapGesture {
                            if (selectedCategories.contains(cat) && selectedCategories.count > 1) {
                                selectedCategories.removeAll(where: { $0 == cat})
                            }
                            else {
                                selectedCategories.append(cat)
                            }
                        }
                    }
                } header: {
                    Text("Categorias")
                }
            }
            
            .navigationTitle(Text("Configure a partida"))
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
