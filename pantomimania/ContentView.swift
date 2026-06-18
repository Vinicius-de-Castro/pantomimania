import SwiftUI
struct ContentView: View {
    @Environment(NavManager.self) var navMan
    var body: some View {
        @Bindable var nav = navMan
        NavigationStack(path: $nav.path){
            HStack{
                Image("Images/mainScreen")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding()
                    .padding(.leading, -200)
                VStack {
                    Image("Images/logo")
                        .padding(.vertical)
                    Button3D(text: "Jogar", systemImage: "play.fill") {
                        nav.navigate(to: .playerList)
                    }
                    .scaleEffect(1.5)
                    .padding()
                }
                .padding()
                .padding(.trailing, 64)
            }
            .navigationDestination(for: Route.self) {
                route in switch route {
                case .playerList:
                    PlayerListView()
                case .matchOptions:
                    MatchOptionsView()
                case .nextRound:
                    NextRoundView()
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
