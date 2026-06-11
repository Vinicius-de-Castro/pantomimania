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
            return Color.green
        case .normal:
            return Color.yellow
        case .hard:
            return Color.red
        }
    }
    
    @Binding var degree: Double
    
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 28)
                .fill(.quaternary)
                .stroke(cardColor, lineWidth: 4)
                .aspectRatio(3/4, contentMode: (.fit))
            Text(name)
                .font(.title)
                .fontWeight(.bold)
        }
        .rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
    }
}

struct CardBack: View {
    
    var name: String
    
    var difficulty: Difficulty
    
    var cardColor: Color {
        switch difficulty {
        case .easy:
            return Color.green
        case .normal:
            return Color.yellow
        case .hard:
            return Color.red
        }
    }
    
    @Binding var degree: Double
    
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 28)
                .fill(cardColor)
                .aspectRatio(3/4, contentMode: (.fit))
//            Image(systemName: "plus")
//                .resizable(resizingMode: .tile)
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
            withAnimation(.linear(duration: 0.1)) {
                backDegree = 90
            }
            withAnimation(.linear(duration: 0.1).delay(0.1)){
                frontDegree = 0
            }
        }
        else {
            withAnimation(.linear(duration: 0.1)) {
                frontDegree = -90
            }
            withAnimation(.linear(duration: 0.1).delay(0.1)){
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
