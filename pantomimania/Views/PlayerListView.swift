import SwiftUI
struct PlayerListView: View {
    @Environment(NavManager.self) var nav
    
    @Environment(GameState.self) var game
    
    @State var playerList: [Player] = []
    
    var body: some View {
        VStack (alignment: .center, spacing: 0){
            PantoTopBar(
                title: "Jogadores",
                subtitle: "Adicione entre 2 a 4 jogadores",
            
                continueButtonAction: {
                    game.playerList = playerList
                    nav.navigate(to: .matchOptions)
                },
                continueButtonTitle: "Continuar",
                continueButtonDisableMode: (
                    (playerList.count < 2 || playerList.contains(where: { $0.name.isEmpty })) ?
                        .disabled : .none
                 )
            
            )
            Spacer()
            HStack (alignment: .top){
                ForEach(playerList) { player in
                    @Bindable var bindablePlayer = player
                    VStack (alignment: .center, spacing: 10) {
                        player.mascot!
                            .resizable()
                            .foregroundStyle(Color.accentColor)
                            .aspectRatio(3/4, contentMode: .fit)
                            .clipShape(
                                RoundedRectangle(cornerRadius: 28)
                            )
                        TextField("Nome", text: $bindablePlayer.name)
                            .padding()
                            .background(Color("Colors/background/bg2"))
                            .clipShape(
                                RoundedRectangle(cornerRadius: 28)
                            )
                            .overlay{
                                RoundedRectangle(cornerRadius: 28)
                                    .stroke(Color("Colors/background/border"), lineWidth: 2)
                            }
                        RoundButton3D(mainColor: Color("Colors/general/red1"), systemImage: "xmark",
                            action: {
                            playerList.removeAll(where: { $0.id == player.id})
                        }
                        )
                        .padding(.top, 8)
                    }
                    .containerRelativeFrame(.horizontal, count: 5, spacing: 0)
                }
                .animation(.spring(duration: 0.15), value: self.$playerList.count)
                if playerList.count < 4 {
                    VStack(alignment: .center, spacing: 10) {
                        GeometryReader { geo in
                            VStack (alignment: .center) {
                                Spacer()
                                Text("Adicionar")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .padding(.top)
                                    .multilineTextAlignment(.center)
                                
                                Image(systemName: "plus.circle.fill")
                                    .resizable()
                                    .aspectRatio(1/1, contentMode: .fit)
                                    .foregroundStyle(.white, .accent)
                                    .frame(width: geo.size.width * 0.3)
                                Spacer()
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                        .aspectRatio(3/4, contentMode: .fit)
                        .background(
                            RoundedRectangle(cornerRadius: 28)
                                .foregroundStyle(Color("Colors/background/bg2"))
                        )
                        .overlay {
                            RoundedRectangle(cornerRadius: 28)
                                .stroke(Color("Colors/background/border"), lineWidth: 2)
                        }
                        
                        
                        Group {
                            TextField("Nome", text: .constant(""))
                                .padding()
                                .overlay{
                                    RoundedRectangle(cornerRadius: 28)
                                        .stroke(.quaternary, lineWidth: 2)
                                }
                            
                            RoundButton3D(mainColor: Color("Colors/general/red1"), systemImage: "xmark",
                                action: {
                            }
                            )
                            .padding(.top, 8)
                        }
                        .hidden()
                        .accessibilityHidden(true)
                        .allowsHitTesting(false)
                    }
                    .animation(.spring(duration: 0.15), value: self.$playerList.count)
                    .containerRelativeFrame(.horizontal, count: 5, spacing: 0)
                    .onTapGesture {
                        
                        
                        let playerMascot: Image
                        let playerColor: Color
                        switch playerList.count {
                        case 0:
                            playerMascot = Image("Images/characters/blue/blueCard")
                            playerColor = Color("Colors/mascot/bluealien")
                        case 1:
                            playerMascot = Image("Images/characters/yellow/yellowCard")
                            playerColor = Color("Colors/mascot/yellowbummer")
                        case 2:
                            playerMascot = Image("Images/characters/pink/pinkCard")
                            playerColor =  Color("Colors/mascot/pinkheart")
                        case 3:
                            playerMascot = Image("Images/characters/orange/orangeCard")
                            playerColor = Color("Colors/mascot/redtooth")
                        default:
                            playerMascot = Image("Images/characters/blue/blueCard")
                            playerColor = Color("Colors/mascot/bluealien")
                        }
                        
                        playerList.append(
                            Player(
                                name: "Jogador \(playerList.count + 1)",
                                mascot: playerMascot,
                                color: playerColor
                            )
                        )
                    }
                    .animation(.spring(duration: 0.15), value: self.$playerList.count)
                }
                
            }
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .overlay(alignment: .topTrailing){
//            Button3D(text: "Continuar",
//                     disableMode: (
//                        (playerList.count < 2 || playerList.contains(where: { $0.name.isEmpty })) ?
//                            .disabled : .none
//                     )
//            ) {
//                game.playerList = playerList
//                nav.navigate(to: .matchOptions)
//            }
//            .padding(.trailing, 24)
//            .padding(.top, 16)
//        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    PlayerListView()
        .environment(NavManager())
        .environment(GameState())
}
