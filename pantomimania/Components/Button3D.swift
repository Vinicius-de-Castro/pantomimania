import SwiftUI

enum disableMode {
    case none
    case disabled
    case visually
}

struct Button3D: View {
    
    private let textColor: Color = .white
    
    private let shadowColor: Color = Color("Colors/general/orange-bg")
    
    var mainColor: Color = Color("Colors/general/orange-primary")
    
    var text: String = ""
    
    var systemImage: String = ""
    
    var disableMode: disableMode = .none
    
    @State var isPressed: Bool = false
    
    @Environment(\.isEnabled) private var isEnabled
    
    var width: CGFloat? = nil
    
    var height: CGFloat? = nil
    
    var action: () -> Void = { }
    
    var body: some View {
        
        let isVisuallyDisabled: Bool = (disableMode == .disabled || disableMode == .visually || !isEnabled)
        
        let isInteractive: Bool = (disableMode != .disabled && isEnabled)
        
        let backgroundColor: Color = {
            isVisuallyDisabled ?
            Color.gray :
            mainColor
        }()
        
        HStack {
            if systemImage.isEmpty == false {
                Image(systemName: systemImage)
                .fontWeight(.bold)
                .foregroundColor(textColor)
            }
            if text.isEmpty == false {
                Text(text)
                    .fontWeight(.bold)
                    .foregroundColor(textColor)
                    .multilineTextAlignment(.leading)
            }
        }
        .padding()
        .padding(.horizontal)
        .frame(maxWidth: width, maxHeight: height)
        .offset(x: 0, y: (isPressed || isVisuallyDisabled) ? -2 : -6)
        .shadow(color: Color(.black.opacity(0.25)), radius: 0, x: 0, y: 2)
        .background(
            ZStack {
                RoundedRectangle(cornerRadius: 28)
                    .foregroundStyle(
                        backgroundColor
                            .mix(with: shadowColor, by: isEnabled ? 0.6 : 1)
                    )
                
                RoundedRectangle(cornerRadius: 28)
                    .foregroundStyle(
                        backgroundColor
                            .shadow(.inner(color: .white.opacity(0.2) ,radius: 0, x: 0, y: -4))
                    )
                .offset(x: 0, y: (isPressed || isVisuallyDisabled) ? -2 : -6)
            }
        )
        .onTapGesture {
                guard isInteractive else { return }
                
                withAnimation(.easeInOut(duration: 0.1)) {
                    isPressed = true
                }
                action()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    if isEnabled{
                        withAnimation(.easeInOut(duration: 0.1)) {
                            isPressed = false
                        }
                    }
                }
        }
        .disabled(disableMode == .disabled)
    }
}
