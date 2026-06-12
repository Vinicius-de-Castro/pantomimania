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
    
    @Environment(\.horizontalSizeClass) var orientation
    
    @State var selectedPrompt: Performance? = nil
    
    @State var performanceOptions: [Performance] = []
    
    var body: some View {
        VStack {
            HStack {
                ForEach(performanceOptions) { perfo in
                    
                    let isSelected = selectedPrompt?.id == perfo.id
                    
                    var difficulty: Difficulty {
                        switch performanceOptions.firstIndex(where: { $0.id == perfo.id}) {
                        case 0:
                            return .easy
                        case 1:
                            return .medium
                        case 2:
                            return .hard
                        default:
                            return .easy
                        }
                    }
                    CardView(name: perfo.name, isFlipped: isSelected, difficulty: difficulty)
                        .onTapGesture {
                            selectedPrompt = perfo
                        }
                }
            }
            .padding()
            
            Spacer()
            
            ZStack(alignment: .topLeading){
                RoundedRectangle(cornerRadius: 28)
                    .foregroundStyle(.quaternary)
                    .frame(maxWidth: .infinity)
                
                Text(selectedPrompt?.description ?? "Selecione um prompt!")
                    .padding(32)
            }
            .overlay(alignment: .topLeading) {
                let diff = performanceOptions.firstIndex(where: { $0.id == selectedPrompt?.id})
                if diff != nil{
                    let color = [Color("Colors/level/easy-green"), Color("Colors/level/medium-yellow"), Color("Colors/level/hard-red")][diff!]
                    let text = ["Fácil", "Médio", "Difícil"][diff!]
                    Text(text)
                        .padding()
                        .background(
                            Capsule()
                                .fill(color)
                        )
                        .padding(.horizontal, 32)
                        .padding(.vertical, -32)
                }
            }
            .padding(.horizontal, 128)
            .padding(.vertical, 64)
        }
        .toolbar {
            Button("Continuar") {
                nav.navigate(to: .timer)
            }
            .disabled(selectedPrompt == nil)
            .buttonStyle(.borderedProminent)
            .foregroundStyle(Color.primary)
            .tint(Color.accentColor)
        }
        .navigationTitle("Escolha seu prompt!")
        .navigationBarBackButtonHidden(true)
        .onAppear {
            performanceOptions = [
                getPerformance(difficulty: .easy, game: game),
                getPerformance(difficulty: .medium, game: game),
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
        if difficulty == .medium {
            performances = category.mediumPerformances
        }
        if difficulty == .hard {
            performances = category.hardPerformances
        }
        options.insert(contentsOf: performances, at: options.count)
    }
    return options.randomElement()!
}
