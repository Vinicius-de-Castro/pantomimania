//
//  GameOverView.swift
//  Panto Party
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
    
    var imageArray: [Image] {
        game.gallery.map({Image(uiImage: $0)})
    }
    
    var body: some View {
        
        VStack{
            if game.photoPermission && !game.gallery.isEmpty {
                VStack {
                    PantoTopBar(
                        title: "Melhores Momentos",
                        subtitle: "Confira os melhores momentos de cada rodada"
                        
                    )
                    if game.gallery.first != nil {
                        ZStack {
                            ScrollView (.horizontal, showsIndicators: false) {
                                HStack{
                                    ForEach(game.gallery, id: \.self) { photo in
                                        let polaroidColor = colors[game.gallery.firstIndex(of: photo) ?? 0 % 4]
                                        VStack{
                                            Image(uiImage: photo)
                                                .resizable()
                                                .aspectRatio(photo.size.width / photo.size.height, contentMode: .fit)
                                                .clipped()
                                            Text("")
                                                .fontWeight(.bold)
                                                .padding()
                                                .padding(.vertical)
                                        }
                                        .background(polaroidColor)
                                        .clipShape(
                                            RoundedRectangle(cornerRadius: 28)
                                        )
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 28)
                                                .stroke(polaroidColor, lineWidth: 8)
                                        )
                                        .padding()
                                    }
                                }
                                .scrollTargetLayout()
                                .frame(maxHeight: .infinity)
                            }
                            .padding()
                            .scrollTargetBehavior(.viewAligned)
                        }
                    }
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
            HStack{
                Button3D(text: "Jogar novamente", systemImage: "arrow.uturn.backward"){
                    nav.backToRoot()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        game.gallery.removeAll()
                    }
                }
                
            #if !targetEnvironment(macCatalyst)
                ShareLink(items: imageArray) { photo in
                        SharePreview("", image: photo)
                    } label: {
                        Button3D(mainColor: Color("Colors/mascot/bluealien"), text: "Salvar imagens", systemImage: "square.and.arrow.up")
                            .allowsHitTesting(false)
                    }
            #endif
                
                
            }
        }
        .navigationBarBackButtonHidden(true)
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    GameOverView()
        .environment(NavManager())
        .environment(GameState())
}
