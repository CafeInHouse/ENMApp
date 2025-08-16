//
//  MockHomeCoordinator.swift
//  HomeServiceTests
//
//  Created by linsaeng on 8/17/25.
//

import Foundation
import SwiftUI
@testable import HomeService
import HomeDomain

actor MockHomeCoordinator: ObservableObject {
    @Published var path = NavigationPath()
    @Published var viewState: HomeCoordinator.ViewState = .loading
    
    var navigateCallCount = 0
    var lastNavigatedRoute: HomeCoordinator.Route?
    
    func navigate(to route: HomeCoordinator.Route) {
        navigateCallCount += 1
        lastNavigatedRoute = route
        path.append(route)
    }
    
    func goBack() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }
    
    func popToRoot() {
        path = NavigationPath()
    }
}