//
//  HomeFeatureViewModel.swift
//  HomeFeature
//
//  Created by linsaeng on 8/16/25.
//

import Foundation

import HomeDomain

public final class HomeFeatureViewModelImpl: ObservableObject {
    
    enum ViewState: Equatable {
        case loading
        case normal
        case error
    }
    
    private let usecase: any HomeUsecase
    private var fetchRequestTask: Task<Void, Never>?
    
    @Published private(set) var viewState: ViewState = .loading
    @Published public private(set) var products: [Product] = []
    
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
