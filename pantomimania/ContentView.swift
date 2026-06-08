//
//  ContentView.swift
//  pantomimania
//
//  Created by Vinicius Rodrigues de Castro on 03/06/26.
//

import SwiftUI

struct ContentView: View {

    @Environment(NavManager.self) var navMan
    var body: some View {
        @Bindable var nav = navMan
        NavigationStack(path: $nav.path){
            HStack{
                Circle()
                    .containerRelativeFrame(.horizontal, count: 3, spacing: 20)
                    .foregroundStyle(.blue)
//                    .distortionEffect(0.2, maxSampleOffset: 1)
                    .blur(radius: 100)
                    .padding()
                VStack {
                    Text("Nome do app")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Button{
                        nav.navigate(to: .playerList)
                    } label: {
                        Label("Jogar", systemImage: "play.fill")
                            .foregroundStyle(Color.white)
                            .background(){
                                RoundedRectangle(cornerRadius: 16)
                                    .padding()
                            }
                            .padding()
                            .font(.title)
                            .padding()
                    }
                }
                .padding()
            }
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .playerList:
                    PlayerListView()
                case .matchOptions:
                    MatchOptionsView()
                case .playerTurn:
                    PlayerTurnView()
                case .promptSelection:
                    PromptSelectionView()
                case .timer:
                    TimerView()
                case .gameOver:
                    GameOverView()
                }
                
            }
        }
    }
}

#Preview {
    ContentView()
}
