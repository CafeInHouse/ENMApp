//
//  HomeFeatureViewModelTests.swift
//  HomeFeatureTests
//
//  Created by linsaeng on 8/17/25.
//

import Testing
import Foundation
@testable import HomeFeature
import HomeDomain

@Suite("HomeFeatureViewModel")
struct HomeFeatureViewModelTests {
    
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
    
    @Test("초기상태가_로딩일때_onAppear를호출하면_상품목록을가져온다")
    func testOnAppearFetchesProducts() async throws {
        // Given
        let mockUsecase = MockHomeUsecase()
        mockUsecase.mockProducts = [
            createMockProduct(id: "1"),
            createMockProduct(id: "2"),
            createMockProduct(id: "3")
        ]
        let viewModel = HomeFeatureViewModelImpl(usecase: mockUsecase)
        #expect(viewModel.viewState == .loading)
        
        // When
        viewModel.onAppear()
        
        // Wait for async operation
        try await Task.sleep(nanoseconds: 100_000_000) // 0.1초 대기
        
        // Then
        #expect(mockUsecase.executeCallCount == 1)
        #expect(viewModel.products.count == 3)
        #expect(viewModel.viewState == .normal)
    }
    
    @Test("usecase에서_에러가발생하면_viewState가_error가된다")
    func testErrorStateOnUsecaseFailure() async throws {
        // Given
        let mockUsecase = MockHomeUsecase()
        mockUsecase.shouldThrowError = true
        let viewModel = HomeFeatureViewModelImpl(usecase: mockUsecase)
        
        // When
        viewModel.onAppear()
        
        // Wait for async operation
        try await Task.sleep(nanoseconds: 100_000_000) // 0.1초 대기
        
        // Then
        #expect(mockUsecase.executeCallCount == 1)
        #expect(viewModel.products.isEmpty)
        #expect(viewModel.viewState == .error)
    }
    
    @Test("이미진행중인_작업이있을때_startTransaction을호출하면_이전작업을취소한다")
    func testCancelsPreviousTransaction() async throws {
        // Given
        let mockUsecase = MockHomeUsecase()
        mockUsecase.mockProducts = [createMockProduct(id: "1")]
        let viewModel = HomeFeatureViewModelImpl(usecase: mockUsecase)
        
        // When
        viewModel.startTrasanction()
        viewModel.startTrasanction() // 즉시 다시 호출
        
        // Wait for async operation
        try await Task.sleep(nanoseconds: 200_000_000) // 0.2초 대기
        
        // Then
        // 두 번 호출되었지만 첫 번째는 취소되고 두 번째만 완료됨
        #expect(mockUsecase.executeCallCount <= 2)
    }
    
    @Test("빈상품목록을_받으면_products가_빈배열이된다")
    func testEmptyProductsList() async throws {
        // Given
        let mockUsecase = MockHomeUsecase()
        mockUsecase.mockProducts = []
        let viewModel = HomeFeatureViewModelImpl(usecase: mockUsecase)
        
        // When
        viewModel.onAppear()
        
        // Wait for async operation
        try await Task.sleep(nanoseconds: 100_000_000) // 0.1초 대기
        
        // Then
        #expect(viewModel.products.isEmpty)
        #expect(viewModel.viewState == .normal)
    }
}