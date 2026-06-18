//
//  NavManager.swift
//  pantomimania
//
//  Created by Vinicius Rodrigues de Castro on 03/06/26.
//

import SwiftUI
import Foundation
import Observation

enum Route: Hashable {
    case playerList
    case matchOptions
    case nextRound
    case playerTurn
    case promptSelection
    case timer
    case gameOver
}

@Observable
class NavManager {
    var path = NavigationPath()
    
    func navigate(to route: Route) {
        path.append(route)
    }
    
    func back() {
        path.removeLast()
    }
    
    func backBy(count: Int) {
        path.removeLast(count)
    }
    
    func backToRoot() {
        path.removeLast(path.count)
    }
}
