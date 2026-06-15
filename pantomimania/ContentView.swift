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
                    .padding(.leading, -120)
                VStack {
                    Text("panto\nparty")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundStyle(Color("Colors/text/primary"))
                    Button {
                        nav.navigate(to: .playerList)
                    }
                        label: {
                            Label("Jogar", systemImage: "play.fill")
                                .padding(32)
                                .padding(.horizontal)
                                .background(
                                    Capsule()
                                        .fill(Color("Colors/general/orange-primary"))
                                )
                                .font(.title)
                                .padding()
                                .foregroundStyle(.white)
                        }
                }
                .padding()
                .padding(.trailing, 160)
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
