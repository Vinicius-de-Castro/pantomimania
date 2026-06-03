//
//  pantomimaniaApp.swift
//  pantomimania
//
//  Created by Vinicius Rodrigues de Castro on 03/06/26.
//

import SwiftUI

@main
struct pantomimaniaApp: App {
    @State var navMan = NavManager()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(navMan)
        }
    }
}
