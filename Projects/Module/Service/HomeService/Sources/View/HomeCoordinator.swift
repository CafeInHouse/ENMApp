//
//  HomeViewModel.swift
//  HomeService
//
//  Created by linsaeng on 8/16/25.
//

import Foundation
import SwiftUI

import HomeDomain

public class HomeCoordinator: ObservableObject {
    
    @Published var path = NavigationPath()
    
    public enum Route: Hashable {
        case home
        case detail(Product)
    }
    
    public enum ViewState: Equatable {
        case loading
        case normal
    }
    
    @Published var viewState: ViewState = .loading
    
    public init() {}
    
    func onAppear() {
        viewState = .normal
    }
}

extension HomeCoordinator {

    func navigate(to route: Route) {
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


