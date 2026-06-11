import SwiftUI
struct PlayerListView: View {
    @Environment(NavManager.self) var nav
    
    @Environment(GameState.self) var game
    
    @State var playerList: [Player] = []
    
    var body: some View {
        VStack (alignment: .center){
            Text("Adicione 2 a 4 jogadores")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(50)
            HStack (alignment: .top){
                ForEach(playerList) { player in
                    @Bindable var bindablePlayer = player
                    VStack (alignment: .center, spacing: 10) {
                        RoundedRectangle(cornerRadius: 28)
                            .foregroundStyle(Color.accentColor)
                            .aspectRatio(3/4, contentMode: .fit)
                        TextField("Nome", text: $bindablePlayer.name)
                            .padding()
                            .overlay{
                                RoundedRectangle(cornerRadius: 28)
                                    .stroke(.quaternary, lineWidth: 2)
                            }
                        Button {
                            playerList.removeAll(where: { $0.id == player.id})
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .resizable()
                                .tint(Color.red)
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
                                .foregroundStyle(.white, .blue)
                                .padding(.horizontal, 64)
                            Spacer()
                        }
                        .frame(maxWidth: .infinity)
                        .aspectRatio(3/4, contentMode: .fit)
                        .background(
                            RoundedRectangle(cornerRadius: 28)
                                .foregroundStyle(.quaternary)
                        )
                        
                        
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
                                    .tint(Color.red)
                                    .aspectRatio(1/1, contentMode: .fit)
                                    .containerRelativeFrame(.vertical, count: 20, spacing: 0)
                                    .containerRelativeFrame(.horizontal, count: 20, spacing: 0)
                            }
                        }
                        .hidden()
                    }
                    .containerRelativeFrame(.horizontal, count: 5, spacing: 0)
                    .onTapGesture {
                        playerList.append(Player(name: "Jogador \(playerList.count + 1)"))
                    }
                }
            }
        }
        .toolbar {
            Button("Continuar") {
                game.playerList = playerList
                nav.navigate(to: .matchOptions)
            }
            .disabled(playerList.count < 2 || playerList.contains(where: { $0.name.isEmpty }))
            .buttonStyle(.borderedProminent)
            .foregroundStyle(Color.primary)
            .tint(Color.accentColor)
        }
        .navigationTitle("Lista de jogadores")
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    PlayerListView()
        .environment(NavManager())
        .environment(GameState())
}
