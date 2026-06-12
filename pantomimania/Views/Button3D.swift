import SwiftUI
struct Button3D: View {
    var body: some View {
        Button("Text", action: {print("Hello, World!")})
            .buttonStyle(Circle3D())
    }
}
struct Circle3D: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .font(.system(size: 35, weight: .bold, design: .rounded))
            .padding(10)
            .background(
                ZStack {
                    Ellipse()
                        .fill(.yellow.mix(with: .black, by: 0.1))
                        .stroke(.yellow.mix(with: .black, by: 0.1),lineWidth: 4)
                        .frame(width: 80, height: 60)
                        .offset(x: 0, y: 10)
                    
                    RoundedRectangle(cornerRadius: 2)
                        .fill(.yellow.mix(with: .black, by: 0.1))
                        .frame(width: 84, height: 12)
                        .offset(x: 0, y: 6)
                    
                    Ellipse()
                        .fill(.yellow)
                        .stroke(.yellow.mix(with: .black, by: 0.1),lineWidth: 4)
                        .frame(width: 80, height: 60)
                }
            )
            .offset(y: configuration.isPressed ? 10 : 0)
    }
}
#Preview {
    Button(action: { print("Pressed")}) {
        Label ("", systemImage: "star")
    }
    .buttonStyle(Circle3D())
}
#Preview {
        Button3D()
}
