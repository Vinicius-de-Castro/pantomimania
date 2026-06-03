//
//  PromptSelectionView.swift
//  pantomimania
//
//  Created by Vinicius Rodrigues de Castro on 03/06/26.
//

import SwiftUI

struct PromptSelectionView: View {
    
    @Environment(NavManager.self) var nav
    
    var body: some View {
        VStack{
            Text("Escolha seu prompt!!!")
            Button("Performar"){
                nav.navigate(to: .timer)
            }
        }
    }
}
