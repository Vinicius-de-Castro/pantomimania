//
//  CameraView.swift
//  POC-photos
//
//  Created by Vinicius Rodrigues de Castro on 01/06/26.
//

import SwiftUI

struct CameraView: View {
    var cameraManager: CameraManager
    var onPhotoCaptured: (UIImage) -> Void
    @Environment(\.dismiss) var dismiss
    
    @State private var showPreview: Bool = false
    @State private var capturedPhoto: UIImage?
    
    var body: some View{
        ZStack {
            if let capturedPhoto, showPreview {
                Image(uiImage: capturedPhoto)
                    .resizable()
                    .scaledToFit()
                    .clipShape(Capsule())
                    .overlay(Capsule().stroke(style: StrokeStyle(lineWidth: 4)))
                    .padding()
                    .ignoresSafeArea()
                VStack {
                    HStack{
                        Button("Take another photo") {
                            onPhotoCaptured(capturedPhoto)
                            dismiss()
                        }
                    }
                }
                .frame(alignment: .bottom)
            } else {
                GeometryReader{ _ in
                    CameraPreview(sessionLayer: cameraManager.getPreviewLayer())
                        .ignoresSafeArea()
                }
                VStack {
                    Spacer()
                    Button(action: {
                        cameraManager.takePhoto()
                    }) {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 70, height: 70)
                            .overlay(Circle().stroke(Color.black, lineWidth: 2))
                            .padding(.bottom, 20)
                    }
                }
            }
        }
        .onAppear { cameraManager.startSession() }
        .onDisappear { cameraManager.stopSession() }
        .onChange(of: cameraManager.capturedImage) {
            if let img = cameraManager.capturedImage {
                self.capturedPhoto = img
                self.showPreview = true
            }
        }
    }
}
