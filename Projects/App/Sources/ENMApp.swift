//
//  ENMApp.swift
//  ENMApp
//
//  Created by Claude on 8/16/25.
//

import SwiftUI
import HomeService

@main
struct ENMApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}