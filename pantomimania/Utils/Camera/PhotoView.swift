//
//  PhotoView.swift
//  POC-photos
//
//  Created by Vinicius Rodrigues de Castro on 01/06/26.
//

import SwiftUI

struct PhotoView: View {
    let columns: [GridItem] = [
        GridItem(.flexible()), GridItem(.flexible())
    ]
    
    @State private var showCamera: Bool = false
    @State private var images: [UIImage] = []
    @State private var tempCameraManager = CameraManager()
    
    var body: some View {
        NavigationView {
            VStack {
                if images.isEmpty {
                    VStack(spacing: 16) {
                        Text("You don't have photos!")
                            .font(.title3)
                        Text("Tap on **+** to start adding.")
                            .foregroundColor(.secondary)
                    }
                } else {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 8) {
                            ForEach(images.indices, id: \.self) { index in
                                Image(uiImage: images[index])
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 200, height: 200)
                                    .clipShape(RoundedRectangle(cornerRadius: 16))
                            }
                        }
                        .padding()
                    }
                }
                Button("", systemImage: "plus") {
                    showCamera.toggle()
                }
            }
            .navigationTitle(Text("Photos"))
            .fullScreenCover(isPresented: $showCamera) {
                CameraView(cameraManager: tempCameraManager) { image in
                    images.append(image)
                    tempCameraManager.takePhoto()
                }
            }
        }
    }
}
