//
//  PromptSelectionView.swift
//  pantomimania
//
//  Created by Vinicius Rodrigues de Castro on 03/06/26.
//

import SwiftUI

struct PromptSelectionView: View {
    
    @Environment(NavManager.self) var nav
    @Environment(GameState.self) var game
    @State var selectedPrompt: Performance? = nil
    @State var performanceOptions: [Performance] = []
    
    var body: some View {
        VStack{
            HStack {
                ForEach(performanceOptions) { perfo in
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .containerRelativeFrame(.horizontal, count: 5, spacing: 64)
                            .containerRelativeFrame(.vertical, count: 2, spacing: 64)
                            .foregroundStyle(.quaternary)
                        if perfo.id == selectedPrompt?.id {
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(.blue, lineWidth: 4)
                                .containerRelativeFrame(.horizontal, count: 5, spacing: 64)
                                .containerRelativeFrame(.vertical, count: 2, spacing: 64)
                        }
                    }
                    .onTapGesture {
                        selectedPrompt = perfo
                    }
                }
            }
            
            ZStack{
                RoundedRectangle(cornerRadius: 16)
                    .foregroundStyle(.quaternary)
                    .containerRelativeFrame(.vertical, count: 3, spacing: 64)
                    .containerRelativeFrame(.horizontal, count: 2, spacing: 64)
                    .padding()
                
                Text(selectedPrompt?.description ?? "Selecione um prompt!")
//                    .frame(maxWidth: .infinity)
                    .padding()
            }
            .padding()
        }
        .toolbar {
            Button("Continuar") {
                nav.navigate(to: .timer)
            }
            .buttonStyle(.borderedProminent)
            .foregroundStyle(Color.primary)
            .tint(Color.accentColor)
        }
        .navigationTitle("Escolha seu prompt!")
        .onAppear {
            performanceOptions = [
                getPerformance(difficulty: .easy, game: game),
                getPerformance(difficulty: .normal, game: game),
                getPerformance(difficulty: .hard, game: game)
            ]
        }
    }
}

func getPerformance(difficulty: Difficulty, game: GameState) -> Performance {
    var options: [Performance] = []
    for category in game.selectedCategories {
        var performances: [Performance] = []
        if difficulty == .easy {
            performances = category.easyPerformances
        }
        if difficulty == .normal {
            performances = category.normalPerformances
        }
        if difficulty == .hard {
            performances = category.hardPerformances
        }
        options.insert(contentsOf: performances, at: options.count)
    }
    return options.randomElement()!
}
