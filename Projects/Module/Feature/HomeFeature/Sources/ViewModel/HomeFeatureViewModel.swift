//
//  HomeFeatureViewModel.swift
//  HomeFeature
//
//  Created by linsaeng on 8/16/25.
//

import Foundation

import HomeDomain

/// 홈 피처의 상태 관리를 담당하는 ViewModel입니다.
///
/// HomeFeatureViewModelImpl은 홈 화면의 UI 상태와 비즈니스 로직을 관리합니다.
/// MVVM 패턴을 따라 View와 Model 사이의 중재자 역할을 수행하며,
/// SwiftUI의 ObservableObject로 구현되어 반응형 UI를 지원합니다.
///
/// - Example:
/// ```swift
/// @StateObject private var viewModel = HomeFeatureViewModelImpl(usecase: homeUsecase)
///
/// var body: some View {
///     VStack {
///         if viewModel.isLoading {
///             ProgressView("Loading...")
///         } else {
///             ForEach(viewModel.products) { product in
///                 ProductCardView(product: product)
///             }
///         }
///     }
///     .onAppear {
///         viewModel.onAppear()
///     }
/// }
/// ```
public final class HomeFeatureViewModelImpl: ObservableObject {
    
    /// View의 현재 상태를 나타내는 열거형
    ///
    /// - loading: 데이터 로딩 중
    /// - normal: 정상 상태 (데이터 표시)
    /// - error: 에러 발생 상태
    enum ViewState: Equatable {
        case loading
        case normal
        case error
    }
    
    private let usecase: any HomeUsecase
    private var fetchRequestTask: Task<Void, Never>?
    
    /// 현재 View의 상태
    @Published private(set) var viewState: ViewState = .loading
    /// 조회된 상품 목록
    @Published public private(set) var products: [Product] = []
    
    /// HomeFeatureViewModelImpl을 초기화합니다.
    ///
    /// - Parameter usecase: 비즈니스 로직을 담당하는 HomeUsecase 인스턴스
    ///
    /// - Example:
    /// ```swift
    /// let usecase = HomeUsecaseImpl(repository: repository)
    /// let viewModel = HomeFeatureViewModelImpl(usecase: usecase)
    /// ```
    public init(usecase: any HomeUsecase) {
        self.usecase = usecase
    }
    
    func onAppear() {
        startTrasanction()
    }
    
}

extension HomeFeatureViewModelImpl {
    
    func startTrasanction() {
        fetchRequestTask?.cancel()
        
        fetchRequestTask = Task { [weak self] in
            await self?._startTransaction()
        }
    }
    
    func _startTransaction() async {
        defer { fetchRequestTask = nil }
        await MainActor.run {
            self.viewState = .loading
        }
        do {
            let products = try await usecase.execute()
            await MainActor.run {
                self.products = products
                self.viewState = .normal
            }
        } catch {
            await MainActor.run {
                self.viewState = .error
            }
        }
    }
}
