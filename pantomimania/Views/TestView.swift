//
//  TestView.swift
//  pantomimania
//
//  Created by Vinicius Rodrigues de Castro on 08/06/26.
//

import SwiftUI

struct TestView: View {
    @Environment(GameState.self) var gameState
    var body: some View {
        Text("Ashibalalalala")
        List(gameState.performanceCategories){ cat in
            VStack(alignment: .leading) {
                Text(cat.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Text("Easy")
                    .font(.title)
                    .foregroundStyle(Color.green)
                ForEach(cat.easyPerformances) { perfo in
                    VStack(alignment: .leading){
                        HStack {
                            Image(systemName: perfo.photo)
                            Text(perfo.name)
                                .font(.title2)
                        }
                        Text("- \(perfo.description)")
                            .font(.title3)
                            .padding(.horizontal)
                            .foregroundStyle(.gray)
                    }
                }
                
                
                Text("Medium")
                    .font(.title)
                    .foregroundStyle(Color.yellow)
                ForEach(cat.normalPerformances) { perfo in
                    VStack(alignment: .leading){
                        HStack {
                            Image(systemName: perfo.photo)
                            Text(perfo.name)
                                .font(.title2)
                        }
                        Text("- \(perfo.description)")
                            .font(.title3)
                            .padding(.horizontal)
                            .foregroundStyle(.gray)
                    }
                }
                
                
            }
        }
    }
}
