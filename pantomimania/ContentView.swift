import SwiftUI
struct ContentView: View {
    @Environment(NavManager.self) var navMan
    var body: some View {
        @Bindable var nav = navMan
        NavigationStack(path: $nav.path){
            HStack{
                Circle()
                    .containerRelativeFrame(.horizontal, count: 3, spacing: 20)
                    .foregroundStyle(.blue)
                    .blur(radius: 100)
                    .padding()
        //colocar imagem aqui
                VStack {
                    Text("Seja bem vindo ao Mimika!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Text("Vem brincar com seus amigos")
                        .font(.callout)
                    Button {
                        nav.navigate(to: .playerList)
                    }
                        label: {
                            Label("Jogar", systemImage: "play.fill")
                                .foregroundStyle(Color.black)
                                .padding(20)
                                .background(
                                    RoundedRectangle(cornerRadius: 30)
                                        .fill(Color.blue)
                                )
                                .font(.title)
                                .padding()
                        }
                }
            }
            .navigationDestination(for: Route.self) {
                route in switch route {
                case .playerList:
                    PlayerListView()
                case .matchOptions:
                    MatchOptionsView()
                case .playerTurn:
                    PlayerTurnView()
                case .promptSelection:
                    PromptSelectionView()
                case .timer:
                    TimerView()
                case .gameOver:
                    GameOverView()
                }
            }
        }
    }
}
#Preview {
    ContentView()
        .environment(NavManager())
}
