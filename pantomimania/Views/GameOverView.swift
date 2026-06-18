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
                    TitleAndSubtitleView(title: "Melhores Momentos", subtitle: "Confira os melhores momentos de cada rodada")
//                    Text("Melhores Momentos")
//                        .font(.largeTitle)
//                        .fontWeight(.bold)
//                        .padding(8)
//                    Text("Confira os melhores momentos de cada rodada")
//                        .font(.title2)
//                        .foregroundColor(.secondary)
//                        .padding(.bottom, 16)
                    
//                    TabView {
//                        ForEach(game.gallery, id: \.self) { photo in
//                            
//                            let polaroidColor = colors[game.gallery.firstIndex(of: photo)! % 4]
//                            
//                            VStack{
//                                Image(uiImage: photo)
//                                    .resizable()
//                                    .aspectRatio(photo.size.width / photo.size.height, contentMode: .fit)
//                                    .rotationEffect(Angle(degrees: 90))
//                                Text("Essa vai virar figurinha!!!")
//                                    .fontWeight(.bold)
//                                    .padding()
//                            }
//                            .background(polaroidColor)
//                            .clipShape(
//                                RoundedRectangle(cornerRadius: 26)
//                            )
//                            .overlay(
//                                RoundedRectangle(cornerRadius: 26)
//                                    .stroke(polaroidColor, lineWidth: 8)
//                            )
//                        }
//                        .padding(64)
//                    }
//                    .navigationBarBackButtonHidden(true)
//                    .tabViewStyle(.page)
//                    .buttonStyle(.borderedProminent)
//                    .foregroundStyle(Color.primary)
//                    .tint(Color.accentColor)
                    ZStack {
                        ScrollView (.horizontal, showsIndicators: false) {
                            HStack{
                                ForEach(game.gallery, id: \.self) { photo in
                                    let polaroidColor = colors[game.gallery.firstIndex(of: photo)! % 4]
                                    VStack{
                                        Image(uiImage: photo)
                                            .resizable()
                                            .aspectRatio(photo.size.width / photo.size.height, contentMode: .fit)
                                            .clipped()
                                            .rotationEffect(Angle(degrees: 90))
                                        Text("Melhores momentos!")
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
                                    .padding()
                                }
                            }
                            .scrollTargetLayout()
//                            .padding()
                            .frame(maxHeight: .infinity)
                        }
                        .scrollTargetBehavior(.viewAligned)
                        
//                        HStack {
//                            
//                            RoundButton3D(systemImage: "chevron.backward", action: {
//                                
//                            })
//                            
//                            Spacer()
//                            
//                            RoundButton3D(systemImage: "chevron.forward", action: {
//                                
//                            })
//                            
//                        }
//                        .padding()
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
                    nav.backBy(count: 6)
                    game.gallery.removeAll()
                }
                
                //Aqui virá o botão de salvar imagens
//                Button3D(mainColor: Color("Colors/mascot/bluealien"), text: "Salvar imagens", systemImage: "square.and.arrow.up"){
//                    
//                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay (alignment: .topLeading) {
            RoundButton3D(systemImage: "chevron.backward", action: {
                nav.back()
                }
            )
                .padding(.horizontal, 24)
                .padding(.top, 16)
        }
    }
}

#Preview {
    GameOverView()
        .environment(NavManager())
        .environment(GameState())
}
