import SwiftUI
struct PlayerListView: View {
    @Environment(NavManager.self) var nav
    @State var playerNames: [String] = []
    var body: some View {
        VStack {
            Text("Adicione os jogadores")
                .font(Font.title.bold())
                .padding()
            HStack {
                Rectangle()
                    .background(.black)
                    .frame(width: 100, height: 100)
                Rectangle()
                    .background(.blue)
                    .frame(width: 100, height: 100)
            }
            Button("Jogar") {
                nav.navigate(to: .matchOptions)
            }
            .padding()
        }
    }
}
#Preview {
    ContentView()
        .environment(NavManager())
}
