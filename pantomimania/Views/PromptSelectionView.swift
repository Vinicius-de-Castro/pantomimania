//
//  PromptSelectionView.swift
//  pantomimania
//
//  Created by Vinicius Rodrigues de Castro on 03/06/26.
//

import SwiftUI

func getPerformance(difficulty: Difficulty, game: GameState) -> Performance {
    var options: [Performance] = []
    for category in game.selectedCategories.shuffled() {
        let performances: [Performance] = category.performances.filter({$0.difficulty == difficulty})
        options.insert(contentsOf: performances, at: options.count)
    }
    return options.randomElement()!
}

struct PromptSelectionView: View {
    
    @Environment(NavManager.self) var nav
    
    @Environment(GameState.self) var game
    
    @Environment(\.horizontalSizeClass) var orientation
    
    @State var selectedPrompt: Performance? = nil
    
    @State var performanceOptions: [Performance] = []
    
    var body: some View {
        ZStack {
            VStack {
                TitleAndSubtitleView(title: "Escolha sua performance", subtitle: "Selecione uma carta")
                Spacer()
                
                HStack {
                    ForEach(performanceOptions) { perfo in
                        
                        let isSelected = selectedPrompt?.id == perfo.id
                        
                        let defaultIndex = {
                            switch perfo.difficulty {
                            case .easy:
                                0
                            case .medium:
                                1
                            case .hard:
                                2
                            }
                        }()
                        
                        CardView(name: perfo.name, isFlipped: isSelected, difficulty: perfo.difficulty)
                            .onTapGesture {
                                selectedPrompt = perfo
                            }
                            .containerRelativeFrame(.horizontal, count: 4, spacing: 10)
                            .containerRelativeFrame(.vertical, count: 3, spacing: 10)
                            .zIndex(Double((isSelected ? 3 : defaultIndex)))
                    }
                }
                .padding(.bottom, 64)
                
                Spacer()
                
                ZStack(alignment: .topLeading){
//                        .padding(.bottom)
                    
                    HStack{
                        Text(selectedPrompt?.description ?? "Selecione um prompt!")
                            .font(.title2)
                            .padding(.horizontal)
                        Spacer()
                        
                        RoundButton3D(systemImage: "play.fill", disableMode: (selectedPrompt == nil ? .disabled : .none),
                                      action: {
                            nav.navigate(to: .timer)
                        })
                        .scaleEffect(1.5)
                        .padding()
                    }
                    .padding()
                }
                .background {
                        RoundedRectangle(cornerRadius: 28)
                            .foregroundStyle(Color("Colors/background/bg2"))
                            .frame(maxWidth: .infinity)
                            .overlay {
                                RoundedRectangle(cornerRadius: 28)
                                    .stroke(Color("Colors/background/border"), lineWidth: 2)
                            }
                }
                .overlay(alignment: .topLeading) {
                    let diff = performanceOptions.firstIndex(where: { $0.id == selectedPrompt?.id})
                    if diff != nil{
                        let color = [Color("Colors/level/easy-green"), Color("Colors/level/medium-yellow"), Color("Colors/level/hard-red")][diff!]
                        let text = ["Fácil", "Médio", "Difícil"][diff!]
                        Text(text)
                            .padding()
                            .fontWeight(.bold)
                            .font(.title2)
                            .foregroundStyle(.black)
                            .background(
                                Capsule()
                                    .fill(color)
                            )
                            .padding(.horizontal, 32)
                            .padding(.vertical, -32)
                    }
                }
                Spacer()
            }
        }
        .containerRelativeFrame(.horizontal, count: 10, span: 8, spacing: 0)
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        //        .overlay(alignment: .topTrailing) {
        //            Button3D(text: "Continuar", disableMode: (selectedPrompt == nil ? .disabled : .none)) {
        //                nav.navigate(to: .timer)
        //            }
        //            .padding(.trailing, 24)
        //            .padding(.top, 16)
        //        }
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



#Preview {
    PlayerTurnView()
        .environment(NavManager())
        .environment(GameState())
}
