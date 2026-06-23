//
//  RouletteView.swift
//  pantomimania
//
//  Created by Vinicius Rodrigues de Castro on 22/06/26.
//

import SwiftUI

struct RouletteView: View {
    
    @State var colors: [Color]
    
    @State var rotation: Double = 0
    
    @State var selectedColor: Color
    
    let radius = 150.0
    
    var body: some View {
        
        let selectedIdx = colors.firstIndex(of: selectedColor) ?? 0
        
        let quadrantArc = 360.0 / Double(colors.count)
        
        
        ZStack {
            ForEach(colors, id: \.self) { color in
                let quadrant = colors.firstIndex(of: color)!
                
                Quadrant(count: colors.count/*, radius: radius*/)
                    .fill(color)
                    .rotationEffect(Angle(degrees: quadrantArc * Double(quadrant)))
                    .frame(width: radius*2, height: radius*2)
                
            }
        }
        //        .border(Color.white)
        //        .background{
        //            Circle()
        //                .fill(Color(.white))
        //        }
        .rotationEffect(Angle(degrees: 90 - Double(quadrantArc/2)))
        .rotationEffect(Angle(degrees: rotation))
        .overlay {
            Circle()
                .stroke(.white, lineWidth: 8)
        }
        .overlay(alignment: .center) {
            Triangle()
                .fill(Color("Colors/level/medium-yellow"))
                .stroke(.white, style: StrokeStyle(
                    lineWidth: 8,
                    lineCap: .round,
                    lineJoin: .round
                ))
                .frame(width: 60, height: 60)
                .rotationEffect(Angle(degrees: 180))
                .padding(.top, -180)
        }
        .onAppear {
            rotation = 0
            withAnimation(.bouncy(duration: 3)){
                rotation = 1620 - Double(selectedIdx) * quadrantArc
                
                
            }
        }
    }
}

struct Quadrant: Shape {
    
    let count: Int
    
    //    var radius: Double
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        //        let radius: CGFloat = radius
        let radius = rect.size.width / 2
        
        path.move(to: center)
        path.addArc(center: center, radius: radius, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 360/Double(count)), clockwise: false)
        path.closeSubpath()
        return path
    }
}

//extension Quadrant {
//    func containsItself() -> some View {
//        return self.frame(width: CGFloat(self.radius*2), height: CGFloat(self.radius*2))
//    }
//}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}

#Preview {
    let colors1 = [Color.blue, Color.red]
    let colors2 = [Color.blue, Color.red, Color.yellow]
    let colors3 = [Color.blue, Color.red, Color.yellow, Color.green]
    let selected = colors3.randomElement()
    HStack {
        
        VStack {
            ForEach(colors1, id: \.self) { color in
                RouletteView(
                    colors: colors1,
                    selectedColor: color
                )
            }
        }
        
        //        VStack {
        //
        //            ForEach(colors2, id: \.self) { color in
        //                RouletteView(
        //                    colors: colors2,
        //                    selectedColor: color
        //                )
        //            }
        //        }
        //        VStack {
        //            ForEach(colors3, id: \.self) { color in
        //                RouletteView(
        //                    colors: colors3,
        //                    selectedColor: color
        //                )
        //            }
        //        }
        //
    }
    .background(.black)
    
}
