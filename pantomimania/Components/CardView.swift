//
//  CardView.swift
//  pantomimania
//
//  Created by Vinicius Rodrigues de Castro on 11/06/26.
//

import SwiftUI

struct CardFront: View {
    
    var name: String
    
    var difficulty: Difficulty
    
    var cardColor: Color {
        switch difficulty {
        case .easy:
            return Color("Colors/level/easy-green")
        case .medium:
            return Color("Colors/level/medium-yellow")
        case .hard:
            return Color("Colors/level/hard-red")
        }
    }
    
    @State var cardWidth: CGFloat = 0
    
    @Binding var degree: Double
    
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 28)
                .fill(Color("Colors/background/bg2"))
                .stroke(cardColor, lineWidth: 2)
                .aspectRatio(3/4, contentMode: (.fill))
                .background(
                    GeometryReader { geometry in
                        Color.clear
                            .onAppear {
                                cardWidth = geometry.size.width
                            }
                    }
                )
            Text(name)
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(Color("Colors/text/primary"))
                .padding()
                .minimumScaleFactor(0.5)
                .multilineTextAlignment(.center)
                .padding()
                .frame(maxWidth: cardWidth)
        }
        .rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
    }
}

struct CardBack: View {
    
    var name: String
    
    var difficulty: Difficulty
    
    @Binding var degree: Double
    
    var body: some View {
        
        let bgImage: Image = {
            switch difficulty {
            case .easy:
                return Image("Images/cards/easy")
            case .medium:
                return Image("Images/cards/medium")
            case .hard:
                return Image("Images/cards/hard")
            }
        }()
        
        ZStack {
            bgImage
                .resizable()
                .aspectRatio(3/4, contentMode: (.fill))
                .clipShape(RoundedRectangle(cornerRadius: 28))
        }
        .rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
    }
}

struct CardView: View {
    
    @State private var backDegree = 0.0
    
    @State private var frontDegree = -90.0
    
    let name: String
    
    let isFlipped: Bool
    
    let difficulty: Difficulty
    
    var body: some View {
        ZStack {
            CardFront(name: name, difficulty: difficulty, degree: $frontDegree)
            CardBack(name: name, difficulty: difficulty, degree: $backDegree)
        }
        .onChange(of: isFlipped) {
            flipCard()
        }
    }
    
    func flipCard() {
        if isFlipped {
            withAnimation(.easeInOut(duration: 0.1)) {
                backDegree = 90
            }
            withAnimation(.easeInOut(duration: 0.1).delay(0.1)){
                frontDegree = 0
            }
        }
        else {
            withAnimation(.easeInOut(duration: 0.1)) {
                frontDegree = -90
            }
            withAnimation(.easeInOut(duration: 0.1).delay(0.1)){
                backDegree = 0
            }
        }
    }
}

//#Preview {
//    CardView(
//        name: "Teste",
//        isFlipped: true,
//        difficulty: .easy
//    )
//    .padding()
//}
