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
    
    let colors = [
        Color("Colors/mascot/bluealien"),
        Color("Colors/mascot/pinkheart"),
        Color("Colors/mascot/redtooth"),
        Color("Colors/mascot/yellowbummer")
    ]
    
    var body: some View {
        
        VStack{
            if game.photoPermission {
                VStack {
                    Text("Melhores Momentos")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(8)
                    Text("Confira os melhores momentos de cada rodada")
                        .font(.title2)
                        .foregroundColor(.secondary)
                        .padding(.bottom, 32)
                    
                    TabView {
                        ForEach(game.gallery, id: \.self) { photo in
                            
                            let polaroidColor = colors[game.gallery.firstIndex(of: photo)! % 4]
                            
                            VStack{
                                Image(uiImage: photo)
                                    .resizable()
                                    .aspectRatio(photo.size.width / photo.size.height, contentMode: .fit)
                                    .rotationEffect(Angle(degrees: 90))
                                Text("Essa vai virar figurinha!!!")
                                    .fontWeight(.bold)
                                    .padding()
                            }
                            .background(polaroidColor)
                            .clipShape(
                                RoundedRectangle(cornerRadius: 26)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 26)
                                    .stroke(polaroidColor, lineWidth: 8)
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
