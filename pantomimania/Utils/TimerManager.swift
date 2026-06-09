//
//  TimerManager.swift
//
//  Created by Vinicius Rodrigues de Castro on 02/06/26.
//

import SwiftUI
import Foundation

@Observable class TimerManager {
    var timeElapsed: Int = 0
    var isRunning: Bool = false
    var targetTime: Int = 0
    private var timer: Timer?
    
    var finished: (() -> Void)?
    
    func start(targetTime: Int, finished: @escaping () -> Void) {
        
        if self.targetTime != targetTime {
            self.timeElapsed = 0
        }
        
        self.targetTime = targetTime
        self.finished = finished
        
        guard !isRunning && targetTime > 0 else { return }
        
        timer?.invalidate()
        
        isRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self else { return }
            self.timeElapsed += 1
            if self.timeElapsed >= self.targetTime {
                self.stop()
                self.finished?()
            }
        }
    }
    
    func pause() {
        isRunning = false
        timer?.invalidate()
        timer = nil
    }
    
    func stop() {
        pause()
        timeElapsed = 0
    }
}
