//
//  HomeDetailFeatureViewModel.swift
//  HomeDetailFeature
//
//  Created by Claude on 8/16/25.
//

import Foundation

import HomeDomain

public final class HomeDetailFeatureViewModelImpl: ObservableObject {
    
    enum ViewState: Equatable {
        case loading
        case normal
        case error
    }
    
    private(set) var product: Product
    private let usecse: any HomeUsecase
    private var fetchProdcutRequestTask: Task<Void, Never>?
    
    @Published private(set) var viewState: ViewState = .loading

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
