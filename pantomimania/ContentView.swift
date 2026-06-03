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
            VStack {
                Text("Nome do app")
                Button("Jogar"){
                    nav.navigate(to: .playerList)
                }
            }
            .navigationTitle(Text("Pantomimania"))
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
