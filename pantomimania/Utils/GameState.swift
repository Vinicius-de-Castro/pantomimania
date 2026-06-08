//
//  GameState.swift
//  pantomimania
//
//  Created by Vinicius Rodrigues de Castro on 08/06/26.
//

import Foundation
import UIKit
import Observation

@Observable
class GameState {
    var playerList: [Player]
    
    var cameraManager: CameraManager
    var timerManager: TimerManager
    var gallery: [UIImage]
    
    var performanceCategories: [PerformanceCategory]
    var selectedCategories: [PerformanceCategory]
    
    init() {
        self.playerList = []
        self.cameraManager = CameraManager()
        self.timerManager = TimerManager()
        self.gallery = []
        self.performanceCategories = loadCategories()
        self.selectedCategories = []
    }
}

func loadCategories() -> [PerformanceCategory] {
    if let fileURL = Bundle.main.url(forResource: "data", withExtension: "json") {
        do {
            let data = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            let categories = try decoder.decode([PerformanceCategory].self, from: data)
            return categories
        }
        catch {
            print("Decoding broke: \(error)")
        }
    }
    else {
        print("no file found")
    }
    return []
}
