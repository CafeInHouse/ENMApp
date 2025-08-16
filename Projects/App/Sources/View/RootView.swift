//
//  RootView.swift
//  ENMApp
//
//  Created by linsaeng on 8/16/25.
//

import SwiftUI

// 내부 Module
import HomeService

struct RootView: View {
    
    var body: some View {
        _bodyView
            .onAppear {
                
            }
    }
}

private extension RootView {
    
    var _bodyView: some View {
        HomeView()
    }
}
