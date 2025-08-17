//
//  HomeDetailFeatureViewModel.swift
//  HomeDetailFeature
//
//  Created by Claude on 8/16/25.
//

import Foundation

import HomeDomain

/// 상품 상세 피처의 상태 관리를 담당하는 ViewModel입니다.
///
/// HomeDetailFeatureViewModelImpl은 특정 상품의 상세 정보 화면 UI 상태와
/// 비즈니스 로직을 관리합니다. 초기 상품 정보를 받아 상세 정보를 로드하고,
/// 웹뷰를 통한 상품 페이지 표시를 담당합니다.
///
/// - Example:
/// ```swift
/// @StateObject private var viewModel = HomeDetailFeatureViewModelImpl(
///     product: selectedProduct,
///     usecase: homeUsecase
/// )
///
/// var body: some View {
///     VStack {
///         if viewModel.isLoading {
///             ProgressView("상품 정보 로딩 중...")
///         } else {
///             ProductDetailView(product: viewModel.product)
///         }
///     }
///     .onAppear {
///         viewModel.onAppear()
///     }
/// }
/// ```
public final class HomeDetailFeatureViewModelImpl: ObservableObject {
    
    /// View의 현재 상태를 나타내는 열거형
    ///
    /// - loading: 상품 상세 정보 로딩 중
    /// - normal: 정상 상태 (상세 정보 표시)
    /// - error: 에러 발생 상태
    enum ViewState: Equatable {
        case loading
        case normal
        case error
    }
    
    /// 현재 표시 중인 상품 정보
    private(set) var product: Product
    private let usecse: any HomeUsecase
    private var fetchProdcutRequestTask: Task<Void, Never>?
    
    /// 현재 View의 상태
    @Published private(set) var viewState: ViewState = .loading

    /// HomeDetailFeatureViewModelImpl을 초기화합니다.
    ///
    /// - Parameters:
    ///   - usecase: 비즈니스 로직을 담당하는 HomeUsecase 인스턴스
    ///   - product: 표시할 상품 정보
    ///
    /// - Example:
    /// ```swift
    /// let viewModel = HomeDetailFeatureViewModelImpl(
    ///     usecase: homeUsecase,
    ///     with: selectedProduct
    /// )
    /// ```
    public init(usecase: any HomeUsecase, with product: Product) {
        self.usecse = usecase
        self.product = product
    }
    
    func onAppear() {
        startTransaction()
    }
}

extension HomeDetailFeatureViewModelImpl {
    
    func startTransaction() {
        fetchProdcutRequestTask?.cancel()
        
        fetchProdcutRequestTask = Task { [weak self] in
            await self?._startTransaction()
        }
    }
    
    func _startTransaction() async {
        defer { fetchProdcutRequestTask = nil }
        await MainActor.run {
            self.viewState = .loading
        }
        do {
            let fetchProdcut = try await usecse.execute(with: product)
            await MainActor.run {
                self.product = fetchProdcut
                self.viewState = .normal
            }
            
        } catch {
            await MainActor.run {
                self.viewState = .error
            }
        }
    }
}
