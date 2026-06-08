//
//  PlayerListView.swift
//  pantomimania
//
//  Created by Vinicius Rodrigues de Castro on 03/06/26.
//

import SwiftUI

struct PlayerListView: View {
    
    @Environment(NavManager.self) var nav
    @State var playerNames: [String] = []
    
    var body: some View {
        VStack {
            Text("Adicione os jogadores")
            HStack {
                Rectangle()
                    .background(.blue)
                    .frame(width: 100, height: 100)
                Rectangle()
                    .background(.black)
                    .frame(width: 100, height: 100)
            }
            Button("Jogar") {
                nav.navigate(to: .matchOptions)
            }
        }
    }
}
