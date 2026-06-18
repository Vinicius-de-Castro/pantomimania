import SwiftUI


struct RoundButton3D: View {
    
    private let textColor: Color = .white
    
    private let shadowColor: Color = Color("Colors/general/orange-bg")
    
    var mainColor: Color = Color("Colors/general/orange-primary")
    
    var text: String = ""
    
    var systemImage: String = ""
    
    var disableMode: disableMode = .none
    
    @State var isPressed: Bool = false
    
    @State var contentWidth: CGFloat = 0
    
    @Environment(\.isEnabled) private var isEnabled
    
    var action: () -> Void = { }
    
    var holdAction: (() -> Void)? = nil
    
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
                    .multilineTextAlignment(.center)
            }
        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
//        .padding(.horizontal)
        .offset(x: 0, y: (isPressed || isVisuallyDisabled) ? -2 : -6)
        .shadow(color: Color(.black.opacity(0.25)), radius: 0, x: 0, y: 2)
        .background(
            GeometryReader { geometry in
                Color.clear
                    .onAppear {
                        contentWidth = geometry.size.width
                    }
            }
        )
        .background(
            ZStack {
                Circle()
                    .foregroundStyle(
                        backgroundColor
                            .mix(with: shadowColor, by: isEnabled ? 0.6 : 1)
                    )
                    .frame(width: contentWidth, height: contentWidth)
                
                Circle()
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
        .onLongPressGesture {
            //
        } onPressingChanged: { isPressing in
            guard isInteractive, let holdAction else { return }
            withAnimation(.easeInOut(duration: 0.1)) {
                isPressed = isPressing
            }
            if isPressing {
                holdAction()
                
                func loop() {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                        if isPressed && isEnabled && disableMode != .disabled {
                            
                            holdAction()
                            loop()
                        }
                    }
                }
                loop()
            }
        }
        .disabled(disableMode == .disabled)
    }
}

#Preview {
    HStack {
        RoundButton3D(systemImage: "chevron.backward")
        RoundButton3D(systemImage: "minus")
    }
    
}
