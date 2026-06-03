//
//  TimerView.swift
//  pantomimania
//
//  Created by Vinicius Rodrigues de Castro on 03/06/26.
//

import SwiftUI

struct TimerView: View {
    
    @Environment(NavManager.self) var nav
    
    var body: some View {
        VStack{
            Text("Finja que tem um temporizador aqui (Aperte o botão pfvr)")
            Button("Finalizar") {
                nav.navigate(to: .gameOver)
            }
        }
    }
}
