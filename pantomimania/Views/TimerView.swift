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
            
            // Determine if the user previously authorized camera access.
            var isAuthorized = status == .authorized
            
            // If the system hasn't determined the user's authorization status,
            // explicitly prompt them for approval.
            if status == .notDetermined {
                isAuthorized = await AVCaptureDevice.requestAccess(for: .video)
            }
            
            return isAuthorized
        }
    }


    func setUpCaptureSession() async {
        guard await isAuthorized else { return }
        // Set up the capture session.
    }
    
    var body: some View {
        VStack{
            if game.timerManager.isRunning {
                Text("\(game.timerManager.getTimeLeft())")
            }
        }
        .task {
            let isAuthorized = await isAuthorized
            print(isAuthorized)
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
            guard newTime != lastProcessedSecond else { return }
            lastProcessedSecond = newTime
            let roundLen = game.roundLength
            let whenToTakePhoto: [Int] = [
                roundLen * 3 / 4,
                roundLen * 2 / 4,
                roundLen * 1 / 4,
                1
            ]
            if whenToTakePhoto.contains(game.timerManager.getTimeLeft()) {
                game.cameraManager.takePhoto()
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
