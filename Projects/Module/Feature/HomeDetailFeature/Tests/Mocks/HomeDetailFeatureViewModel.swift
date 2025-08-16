//
//  HomeDetailFeatureViewModel.swift
//  HomeDetailFeatureTests
//
//  Created by linsaeng on 8/17/25.
//

import Foundation
import HomeDomain

// Mock ViewModel for testing
class HomeDetailFeatureViewModel: ObservableObject {
    @Published var product: Product?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let usecase: HomeUsecase
    
    init(usecase: HomeUsecase) {
        self.usecase = usecase
    }
    
    func loadProductDetail(product: Product) async throws {
        isLoading = true
        errorMessage = nil
        
        do {
            let updatedProduct = try await usecase.execute(with: product)
            await MainActor.run {
                self.product = updatedProduct
                self.isLoading = false
            }
        } catch {
            await MainActor.run {
                self.errorMessage = error.localizedDescription
                self.isLoading = false
            }
            throw error
        }
    }
}