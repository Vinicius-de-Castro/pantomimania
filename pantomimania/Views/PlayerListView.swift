import SwiftUI
struct PlayerListView: View {
    @Environment(NavManager.self) var nav
    
    @Environment(GameState.self) var game
    
    @State var playerList: [Player] = []
    
    var body: some View {
        VStack (alignment: .center, spacing: 0){
            Text("Jogadores")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(8)
            Text("Adicione entre 2 a 4 jogadores")
                .font(.title2)
                .foregroundColor(.secondary)
                .padding(.bottom, 32)
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
                                    .stroke(Color("Colors/background/border"), lineWidth: 4)
                            }
                        Button {
                            playerList.removeAll(where: { $0.id == player.id})
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .resizable()
                                .tint(Color("Colors/general/red1"))
                                .aspectRatio(1/1, contentMode: .fit)
                                .containerRelativeFrame(.vertical, count: 20, spacing: 0)
                                .containerRelativeFrame(.horizontal, count: 20, spacing: 0)
                        }
                    }
                    .containerRelativeFrame(.horizontal, count: 5, spacing: 0)
                }
                
                if playerList.count < 4 {
                    VStack(alignment: .center, spacing: 10) {
                    
                        VStack {
                            Spacer()
                            Text("Adicionar")
                                .font(.title3)
                                .fontWeight(.bold)
                                .padding(.top)
                                .multilineTextAlignment(.center)
                            
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .aspectRatio(1/1, contentMode: .fit)
                                .foregroundStyle(.white, .accent)
                                .padding(.horizontal, 64)
                            Spacer()
                        }
                        .frame(maxWidth: .infinity)
                        .aspectRatio(3/4, contentMode: .fit)
                        .background(
                            RoundedRectangle(cornerRadius: 28)
                                .foregroundStyle(Color("Colors/background/bg2"))
                        )
                        .overlay {
                            RoundedRectangle(cornerRadius: 28)
                                .stroke(Color("Colors/background/border"), lineWidth: 4)
                        }
                        
                        
                        Group {
                            TextField("Nome", text: .constant(""))
                                .padding()
                                .overlay{
                                    RoundedRectangle(cornerRadius: 28)
                                        .stroke(.quaternary, lineWidth: 2)
                                }
                            Button {
                                
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .resizable()
                                    .tint(Color("Colors/general/red1"))
                                    .aspectRatio(1/1, contentMode: .fit)
                                    .containerRelativeFrame(.vertical, count: 20, spacing: 0)
                                    .containerRelativeFrame(.horizontal, count: 20, spacing: 0)
                            }
                        }
                        .hidden()
                    }
                    .containerRelativeFrame(.horizontal, count: 5, spacing: 0)
                    .onTapGesture {
                        
                        let playerMascot = {
                            switch playerList.count {
                            case 0:
                                return Image("Images/characters/blue/blueCard")
                            case 1:
                                return Image("Images/characters/yellow/yellowCard")
                            case 2:
                                return Image("Images/characters/pink/pinkCard")
                            case 3:
                                return Image("Images/characters/orange/orangeCard")
                            default:
                                return Image("Images/characters/blue/blueCard")
                            }
                        }
                        
                        playerList.append(
                            Player(
                                name: "Jogador \(playerList.count + 1)", mascot: playerMascot())
                        )
                    }
                }
                
            }
        }
//        .toolbar {
//            Button("Continuar") {
//                game.playerList = playerList
//                nav.navigate(to: .matchOptions)
//            }
//            .disabled(playerList.count < 2 || playerList.contains(where: { $0.name.isEmpty }))
//            .buttonStyle(.borderedProminent)
//            .foregroundStyle(Color.primary)
//            .tint(Color.accentColor)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(alignment: .topTrailing){
            Button3D(text: "Continuar",
                     disableMode: (
                        (playerList.count < 2 || playerList.contains(where: { $0.name.isEmpty })) ?
                            .visually : .none
                     )
            ) {
                game.playerList = playerList
                nav.navigate(to: .matchOptions)
            }
            .padding(.trailing, 24)
            .padding(.top, 16)
        }
//        }
//        .navigationTitle("Lista de jogadores")
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    PlayerListView()
        .environment(NavManager())
        .environment(GameState())
}
