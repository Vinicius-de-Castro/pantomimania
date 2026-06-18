//
//  TitleAndSubtitleView.swift
//  pantomimania
//
//  Created by Vinicius Rodrigues de Castro on 17/06/26.
//

import SwiftUI

struct TitleAndSubtitleView: View {
    let title: String
    let subtitle: String
    
    var body: some View {
        VStack {
            
            Text(title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(Color("Colors/text/primary"))
            
            Text(subtitle)
                .font(.title)
                .foregroundStyle(Color("Colors/text/secondary"))
        }
        .padding()
        .padding(.vertical)
    }
}
