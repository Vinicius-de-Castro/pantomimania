//
//  GameOverView.swift
//  pantomimania
//
//  Created by Vinicius Rodrigues de Castro on 03/06/26.
//

import SwiftUI

struct GameOverView: View {
    
    @Environment(NavManager.self) var nav
    
    @Environment(GameState.self) var game
    
    var body: some View {
        VStack{
            Text("Game Over")
            Button("Play Again"){
                nav.backBy(count: 5)
            }
        }
    }
}
