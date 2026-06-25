//
//  PantoTopBar.swift
//  Panto Party
//
//  Created by Vinicius Rodrigues de Castro on 25/06/26.
//

import SwiftUI

struct PantoTopBar: View {
    
    var title: String? = nil
    
    var subtitle: String? = nil
    
    var backButtonAction: (() -> Void)? = nil
    
    var continueButtonAction: (() -> Void)? = nil
    
    var continueButtonTitle: String? = nil
    
    var continueButtonDisableMode: DisableMode = .none
    
    var paddingSize: CGFloat = 24
    
    @ScaledMetric var titleSize: CGFloat = 40
    
    @ScaledMetric var subtitleSize: CGFloat = 28
    
    var body: some View {
        HStack {
            HStack {
                if let backButtonAction {
                    RoundButton3D(systemImage: "chevron.backward", action: backButtonAction)
                }
                Spacer()
            }
            .padding(paddingSize)
            .containerRelativeFrame(.horizontal, count: 6, spacing: 0)
            VStack (alignment: .center) {
                if let title {
                    Text(title)
                        .font(.system(size: titleSize))
                        .fontWeight(.bold)
                        .foregroundStyle(Color("Colors/text/primary"))
                        .multilineTextAlignment(.center)
                }
                if let subtitle {
                    Text(subtitle)
                        .font(.system(size: subtitleSize))
                        .foregroundStyle(Color("Colors/text/secondary"))
                        .multilineTextAlignment(.center)
                }
            }
            .padding(paddingSize)
            .containerRelativeFrame(.horizontal, count: 6, span: 4, spacing: 0)
            HStack {
                Spacer()
                if let continueButtonAction, let continueButtonTitle {
                    Button3D(text: continueButtonTitle, action: continueButtonAction)
                }
            }
            .padding(paddingSize)
            .containerRelativeFrame(.horizontal, count: 6, spacing: 0)
        }
    }
}

#Preview {
    PantoTopBar(
        title: "TESTE GIGANTESCO",
        subtitle: "Subtitle",
        backButtonAction: {
            print("teste")
        },
        continueButtonAction: {
            print("teste")
        },
        continueButtonTitle: "Continue"
    )
}
