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
            TabView {
                ForEach(game.gallery, id: \.self) { photo in
                    Image(uiImage: photo)
                        .resizable()
                        .aspectRatio(photo.size.width / photo.size.height, contentMode: .fit)
                        .rotationEffect(Angle(degrees: 90))
                }
            }
            .navigationBarBackButtonHidden(true)
            .tabViewStyle(.page)
            Button("Play Again"){
                nav.backBy(count: 5)
            }
        }
    }
}
