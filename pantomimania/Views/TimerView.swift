//
//  TimerView.swift
//  pantomimania
//
//  Created by Vinicius Rodrigues de Castro on 03/06/26.
//

import SwiftUI

struct TimerView: View {
    
    @Environment(NavManager.self) var nav
    
    @Environment(GameState.self) var game
    
    var body: some View {
        VStack{
            if game.timerManager.isRunning {
                Text("\(game.timerManager.getTimeLeft())")
            }
        }
        .onAppear() {
            game.cameraManager.startSession()
            game.timerManager.start(targetTime: game.roundLength, finished: {
                if game.playerQueue.count < 2 {
                    nav.navigate(to: .gameOver)
                } else {
                    game.playerQueue.removeFirst()
                    nav.backBy(count: 2)
                }
            })
        }
        .onDisappear() {
            game.cameraManager.stopSession()
        }
    }
}
