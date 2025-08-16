//
//  HomeView.swift
//  HomeService
//
//  Created by linsaeng on 8/16/25.
//

import Foundation
import SwiftUI

// 내부 Module
import ENMUI
import HomeDomain
import HomeFeature
import HomeDetailFeature

public struct HomeView: View {
    
    @StateObject private var coordinator = HomeCoordinator()
    
    public init() {}
    
    public var body: some View {
        _bodyView
            .onAppear {
                coordinator.onAppear()
            }
    }
    
    private var _bodyView: some View {
        NavigationStack(path: $coordinator.path) {
            contentView
                .navigationDestination(for: HomeCoordinator.Route.self) { route in
                    destinationView(for: route)
                }
        }
    }
}

private extension HomeView {
    
    @ViewBuilder
    var contentView: some View {
        switch coordinator.viewState {
        case .loading:
            ProgressView("로딩 중...")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
        case .normal:
            homeView

        }
    }
    
    var homeView: some View {
        HomeFeatureView { product in
            coordinator.navigate(to: .detail(product))
        }
    }
    
    @ViewBuilder
    func destinationView(for route: HomeCoordinator.Route) -> some View {
        switch route {
        case .home:
            homeView
            
        case .detail(let product):
            HomeDetailFeatureView(product: product, backButtonTapped: {
                coordinator.goBack()
            })
        }
    }
}

#Preview {
    HomeView()
}
