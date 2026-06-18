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
    
    @State private var showToast: Bool = false
    
    @State private var toastText: String = ""
    
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
        
        VStack {
            TitleAndSubtitleView(title: "Hora de performar", subtitle: "Fique atento(a) no tempo!")
//            Text("Hora de performar")
//                .font(.largeTitle)
//                .fontWeight(.bold)
//                .foregroundStyle(Color("Colors/text/primary"))
//            Text("Fique atento(a) no tempo!")
//                .font(.title)
//                .foregroundStyle(Color("Colors/text/secondary"))
//                .padding(.bottom)
            VStack {
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
                HStack {
                    Button3D(text: game.timerManager.isRunning ? "Pausar" : "Continuar",
                             systemImage: game.timerManager.isRunning ? "pause" : "play") {
                        if game.timerManager.isRunning {
                            game.timerManager.pause()
                        }
                        else {
                            game.timerManager.resume()
                        }
                    }
                    Button3D(mainColor: Color("Colors/general/red1"), text: "Finalizar", systemImage: "checkmark") {
                        game.timerManager.finish()
                    }
                }
                .padding()
            }
        }
        .frame(maxWidth: .infinity)
        .overlay(alignment: .topLeading) {
            if (showToast){
                Label(toastText, systemImage: "camera")
                    .padding()
                    .padding()
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                    .background(.quaternary)
                    .clipShape(RoundedRectangle(cornerRadius: 26))
                    .font(.largeTitle)
                    .overlay {
                        RoundedRectangle(cornerRadius: 26)
                            .stroke(.tertiary)
                    }
                    .containerRelativeFrame(.horizontal, count: 3, spacing: 0)
                    .padding()
            }
        }
        .task {
            _ = await isAuthorized
            game.cameraManager.startSession()
            game.timerManager.start(targetTime: game.roundLength, finished: {
                if game.playerQueue.count < 2 {
                    if game.nextRound == game.roundCount {
                        nav.navigate(to: .gameOver)
                    } else {
                        game.nextRound += 1
                        game.playerQueue.removeAll()
                        game.playerQueue = game.playerList.shuffled()
                        nav.backBy(count: 3)
                    }
                } else {
                    game.playerQueue.removeFirst()
                    nav.backBy(count: 2)
                }
            })
        }
        .navigationBarBackButtonHidden(true)
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
                if game.photoPermission {
                    if (whenToTakePhoto.contains(game.timerManager.getTimeLeft() + 3)) {
                        game.cameraManager.takePhoto()
                        toastText = "Hora da foto! 3.."
                        showToast.toggle()
                    }
                    if whenToTakePhoto.contains(game.timerManager.getTimeLeft() + 2) {
                        toastText = "Hora da foto! 1..."
                    }
                    if whenToTakePhoto.contains(game.timerManager.getTimeLeft() + 1) {
                        toastText = "Hora da foto! 2..."
                    }
                    if whenToTakePhoto.contains(game.timerManager.getTimeLeft()) {
                        showToast.toggle()
                        toastText = "Hora da foto! 3..."
                    }
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
#Preview {
    TimerView()
        .environment(NavManager())
        .environment(GameState())
}
