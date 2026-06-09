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
        VStack{
            HStack {
                ForEach(performanceOptions) { perfo in
                    VStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 16)
                                .fill(.quaternary)
                                .stroke((perfo.id == selectedPrompt?.id ? Color.blue : Color.clear), lineWidth: 4)
                                .aspectRatio(3/4, contentMode: (.fit))
                                Image(systemName: perfo.photo) // Depois precisamos alterar pra utilizar assets
                                    .resizable()
                                    .frame(width: 100, height: 100) // Placeholder, pq os assets vão todos ser em 3:4 mas os ícones não são
                                    .padding()
                        }
                        Text(perfo.name)
                            .font(.title)
                            .fontWeight(.bold)
                    }
                    .onTapGesture {
                        selectedPrompt = perfo
                    }
                }
            }
            .padding()
            
            Spacer()
            
            ZStack(alignment: .topLeading){
                RoundedRectangle(cornerRadius: 16)
                    .foregroundStyle(.quaternary)
                    .frame(maxWidth: .infinity)
                
                Text(selectedPrompt?.description ?? "Selecione um prompt!")
                    .padding(32)
            }
            .overlay(alignment: .topLeading) {
                let diff = performanceOptions.firstIndex(where: { $0.id == selectedPrompt?.id})
                if diff != nil{
                    let color = [Color.green, Color.yellow, Color.red][diff!]
                    let text = ["Fácil", "Normal", "Difícil"][diff!]
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
