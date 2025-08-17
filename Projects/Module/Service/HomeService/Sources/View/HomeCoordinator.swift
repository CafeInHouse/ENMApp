//
//  HomeViewModel.swift
//  HomeService
//
//  Created by linsaeng on 8/16/25.
//

import Foundation
import SwiftUI

import HomeDomain

/// 홈 서비스의 네비게이션과 라우팅을 관리하는 Coordinator입니다.
///
/// HomeCoordinator는 Coordinator 패턴을 구현하여 홈 서비스 내의 화면 전환과
/// 네비게이션 상태를 중앙집중식으로 관리합니다. SwiftUI의 NavigationStack과
/// 연동되어 타입 안전한 네비게이션을 제공합니다.
///
/// - Example:
/// ```swift
/// @StateObject private var coordinator = HomeCoordinator()
///
/// NavigationStack(path: $coordinator.path) {
///     HomeView()
///         .navigationDestination(for: HomeCoordinator.Route.self) { route in
///             coordinator.view(for: route)
///         }
/// }
/// .environmentObject(coordinator)
/// ```
public class HomeCoordinator: ObservableObject {
    
    /// 네비게이션 경로를 관리하는 NavigationPath
    @Published var path = NavigationPath()
    
    /// 홈 서비스 내에서 사용되는 라우트를 정의하는 열거형
    ///
    /// - home: 홈 화면
    /// - detail: 상품 상세 화면 (Product 객체 포함)
    public enum Route: Hashable {
        case home
        case detail(Product)
    }
    
    /// 전체 서비스의 상태를 나타내는 열거형
    ///
    /// - loading: 초기 로딩 중
    /// - normal: 정상 상태
    public enum ViewState: Equatable {
        case loading
        case normal
    }
    
    /// 전체 서비스의 현재 상태
    @Published var viewState: ViewState = .loading
    
    /// HomeCoordinator를 초기화합니다.
    ///
    /// - Note: 초기 상태는 loading으로 설정되며, NavigationPath는 빈 상태로 시작됩니다.
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
