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
            if game.photoPermission {
                VStack {
                    TabView {
                        ForEach(game.gallery, id: \.self) { photo in
                            VStack{
                                Image(uiImage: photo)
                                    .resizable()
                                    .aspectRatio(photo.size.width / photo.size.height, contentMode: .fit)
                                    .rotationEffect(Angle(degrees: 90))
                                Text("Essa vai virar figurinha!!!")
                                    .padding(.horizontal)
                                    .padding(.bottom)
                            }
                            .background(Color.accent)
                            .clipShape(
                                RoundedRectangle(cornerRadius: 26)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 26)
                                    .stroke(Color.accent, lineWidth: 4)
                            )
                        }
                        .padding(64)
                    }
                    .navigationBarBackButtonHidden(true)
                    .tabViewStyle(.page)
                    .buttonStyle(.borderedProminent)
                    .foregroundStyle(Color.primary)
                    .tint(Color.accentColor)
                }
            }
            else {
                VStack{
                    HStack{
                        Image("Images/characters/blue/blueMon")
                            .resizable()
                            .aspectRatio(1/1, contentMode: .fit)
                            .padding()
                        Image("Images/characters/yellow/yellowMon")
                            .resizable()
                            .aspectRatio(1/1, contentMode: .fit)
                            .padding()
                    }
                    HStack{
                        Image("Images/characters/pink/pinkMon")
                            .resizable()
                            .aspectRatio(1/1, contentMode: .fit)
                            .padding()
                        Image("Images/characters/orange/orangeMon")
                            .resizable()
                            .aspectRatio(1/1, contentMode: .fit)
                            .padding()
                    }
                }
                .padding()
            }
            
            Button("Jogar novamente"){
                nav.backBy(count: 5)
                game.gallery.removeAll()
            }
            .padding()
            .background(.accent)
            .foregroundColor(.white)
            .clipShape(Capsule())
        }
    }
}
