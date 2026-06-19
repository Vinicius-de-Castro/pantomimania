//
//  pantomimaniaApp.swift
//  pantomimania
//
//  Created by Vinicius Rodrigues de Castro on 03/06/26.
//

import SwiftUI

@main
struct pantomimaniaApp: App {
    @State private var navMan = NavManager()
    @State private var gameState = GameState()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(navMan)
                .environment(gameState)
        }
    }
}

