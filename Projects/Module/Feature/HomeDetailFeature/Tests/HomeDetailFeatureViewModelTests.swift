//
//  HomeDetailFeatureViewModelTests.swift
//  HomeDetailFeatureTests
//
//  Created by linsaeng on 8/17/25.
//

import Testing
import Foundation
@testable import HomeDetailFeature
import HomeDomain

@Suite("HomeDetailFeatureViewModel")
struct HomeDetailFeatureViewModelTests {
    
    private func createMockProduct(id: String = "1") -> Product {
        return Product(
            id: id,
            name: "테스트 상품 \(id)",
            brand: "테스트 브랜드",
            price: 10000,
            discountPrice: 8000,
            discountRate: 20,
            image: "test\(id).jpg",
            link: "https://test\(id).com",
            tags: ["tag\(id)"],
            benefits: ["benefit\(id)"],
            rating: 4.5,
            reviewCount: 100
        )
    }
    
    @Test("상품정보가_주어졌을때_상세정보를_요청하면_업데이트된_상품정보를_받는다")
    func testLoadProductDetailSuccess() async throws {
        // Given
        let mockUsecase = MockHomeDetailUsecase()
        let originalProduct = createMockProduct(id: "1")
        
        var updatedProduct = originalProduct
        updatedProduct = Product(
            id: "1",
            name: "업데이트된 상품",
            brand: "업데이트된 브랜드",
            price: 15000,
            discountPrice: 12000,
            discountRate: 20,
            image: "updated.jpg",
            link: "https://updated.com",
            tags: ["new", "updated"],
            benefits: ["새로운 혜택"],
            rating: 4.8,
            reviewCount: 200
        )
        
        mockUsecase.mockProduct = updatedProduct
        let viewModel = HomeDetailFeatureViewModel(usecase: mockUsecase)
        
        // When
        try await viewModel.loadProductDetail(product: originalProduct)
        
        // Then
        #expect(mockUsecase.executeWithProductCallCount == 1)
        #expect(viewModel.product?.name == "업데이트된 상품")
        #expect(viewModel.product?.reviewCount == 200)
    }
    
    @Test("상품상세정보_로딩중_에러가발생하면_에러상태가된다")
    func testLoadProductDetailError() async throws {
        // Given
        let mockUsecase = MockHomeDetailUsecase()
        mockUsecase.shouldThrowError = true
        let viewModel = HomeDetailFeatureViewModel(usecase: mockUsecase)
        let product = createMockProduct(id: "1")
        
        // When & Then
        do {
            try await viewModel.loadProductDetail(product: product)
            #expect(Bool(false), "에러가 발생해야 합니다")
        } catch {
            #expect(mockUsecase.executeWithProductCallCount == 1)
            #expect(viewModel.isLoading == false)
            #expect(viewModel.errorMessage != nil)
        }
    }
}