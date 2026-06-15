//
//  TimerView.swift
//  pantomimania
//
//  Created by Vinicius Rodrigues de Castro on 03/06/26.
//

import SwiftUI
import AVFoundation

struct TimerView: View {
    
    @Environment(NavManager.self) var nav
    
    @Environment(GameState.self) var game
    
    @State private var lastProcessedSecond: Int?
    
    var isAuthorized: Bool {
        get async {
            let status = AVCaptureDevice.authorizationStatus(for: .video)
            
            var isAuthorized = status == .authorized
            
            if status == .notDetermined {
                isAuthorized = await AVCaptureDevice.requestAccess(for: .video)
            }
            
            game.photoPermission = isAuthorized
            
            return isAuthorized
        }
    }
    
    
    func setUpCaptureSession() async {
        guard await isAuthorized else { return }
    }
    
    var body: some View {
        
        let progress = CGFloat(game.timerManager.getTimeLeft())/CGFloat(game.roundLength)
        
//        var toastText: String = ""
//        
//        var showToast: Bool = false
        
//        ZStack(alignment: .topLeading) {
            VStack {
                Text("Hora de performar")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(Color("Colors/text/primary"))
                Text("Fique atento(a) no tempo!")
                    .font(.title)
                    .foregroundStyle(Color("Colors/text/secondary"))
                    .padding(.bottom)
                if game.timerManager.isRunning {
                    ZStack{
                        Circle()
                            .trim(
                                from: 0,
                                to: CGFloat(progress)
                            )
                            .stroke(
                                .accent,
                                style: StrokeStyle(
                                    lineWidth: 30,
                                    lineCap: .round
                                )
                            )
                            .rotationEffect(.degrees(270))
                            .animation(.easeInOut, value: progress)
                        
                        Text("\(game.timerManager.getTimeLeft())")
                            .font(.system(size: 120))
                            .fontWeight(.black)
                            .foregroundStyle(.accent)
                    }
                    .padding()
                }
            }
//            if showToast {
//                Text(toastText)
//                    .padding()
//                    .background(Color("Colors/background/bg2"))
//                    .clipShape(RoundedRectangle(cornerRadius: 14))
//                    .overlay(
//                        RoundedRectangle(cornerRadius: 14)
//                            .stroke(Color("Colors/background/border"), lineWidth: 4)
//                    )
//            }
//        }
        .task {
            _ = await isAuthorized
//            print(isAuthorized)
            game.cameraManager.startSession()
            game.timerManager.start(targetTime: game.roundLength, finished: {
                if game.playerQueue.count < 2 {
                    nav.navigate(to: .gameOver)
                } else {
                    game.playerQueue.removeFirst()
                    nav.backBy(count: 2)
                }
            })
        }
        .onDisappear() {
            game.cameraManager.stopSession()
        }
        .onChange(of: game.timerManager.getTimeLeft()) { _, newTime in
            if game.photoPermission {
                guard newTime != lastProcessedSecond else { return }
                lastProcessedSecond = newTime
                let roundLen = game.roundLength
                let whenToTakePhoto: [Int] = [
                    roundLen * 3 / 4,
                    roundLen / 2,
                    roundLen * 1 / 4,
                    0
                ]
                if whenToTakePhoto.contains(game.timerManager.getTimeLeft()) {
//                    showToast = true
//                    toastText = "Hora de tirar a foto! 3..."
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//                        showToast = false
                        game.cameraManager.takePhoto()
//                    }
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                        toastText = "Hora de tirar a foto! 2..."
//                    }
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                        toastText = "Hora de tirar a foto! 1..."
//                    }
                }
                
                
            }
        }
        .onChange(of: game.cameraManager.capturedImage) {
            if let img = game.cameraManager.capturedImage {
                game.gallery.append(img)
                game.cameraManager.capturedImage = nil
            }
        }
    }
}
