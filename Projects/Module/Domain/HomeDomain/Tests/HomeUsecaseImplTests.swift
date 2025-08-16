//
//  HomeUsecaseImplTests.swift
//  HomeDomainTests
//
//  Created by linsaeng on 8/17/25.
//

import Testing
import Foundation
@testable import HomeDomain

@Suite("HomeUsecaseImpl")
struct HomeUsecaseImplTests {
    
    private func createMockProduct(id: String = "1") -> Product {
        return Product(
            id: id,
            name: "테스트 상품 \(id)",
            brand: "테스트 브랜드",
            price: 10000 * Int(id)!,
            discountPrice: 8000 * Int(id)!,
            discountRate: 20,
            image: "test\(id).jpg",
            link: "https://test\(id).com",
            tags: ["tag\(id)", "common"],
            benefits: ["benefit\(id)", "할인"],
            rating: Double.random(in: 3.5...5.0),
            reviewCount: 100 * Int(id)!
        )
    }
    
    @Test("Repository에서_상품목록을_가져오면_Usecase도_동일한_목록을_반환한다")
    func testExecuteReturnsProductsFromRepository() async throws {
        // Given
        let mockRepository = MockHomeRepository()
        mockRepository.mockProducts = [
            createMockProduct(id: "1"),
            createMockProduct(id: "2"),
            createMockProduct(id: "3")
        ]
        let usecase = HomeUsecaseImpl(repository: mockRepository)
        
        // When
        let products = try await usecase.execute()
        
        // Then
        #expect(mockRepository.fetchCallCount == 1)
        #expect(products.count == 3)
        #expect(products[0].id == "1")
        #expect(products[1].id == "2")
        #expect(products[2].id == "3")
    }
    
    @Test("특정상품정보를_요청하면_Repository의_fetchProduct를_호출한다")
    func testExecuteWithProductCallsRepositoryFetchProduct() async throws {
        // Given
        let mockRepository = MockHomeRepository()
        let inputProduct = createMockProduct(id: "5")
        let expectedProduct = Product(
            id: "5",
            name: "업데이트된 상품",
            brand: "업데이트된 브랜드",
            price: 60000,
            discountPrice: 48000,
            discountRate: 20,
            image: "updated.jpg",
            link: "https://updated.com",
            tags: ["new", "updated"],
            benefits: ["새로운 혜택", "추가 할인"],
            rating: 4.8,
            reviewCount: 600
        )
        mockRepository.mockProduct = expectedProduct
        let usecase = HomeUsecaseImpl(repository: mockRepository)
        
        // When
        let product = try await usecase.execute(with: inputProduct)
        
        // Then
        #expect(mockRepository.fetchProductCallCount == 1)
        #expect(product.id == "5")
        #expect(product.name == "업데이트된 상품")
        #expect(product.reviewCount == 600)
    }
    
    @Test("Repository에서_에러가_발생하면_Usecase도_에러를_전파한다")
    func testErrorPropagationFromRepository() async throws {
        // Given
        let mockRepository = MockHomeRepository()
        mockRepository.shouldThrowError = true
        let usecase = HomeUsecaseImpl(repository: mockRepository)
        
        // When & Then
        do {
            _ = try await usecase.execute()
            #expect(Bool(false), "에러가 발생해야 합니다")
        } catch {
            #expect(mockRepository.fetchCallCount == 1)
            #expect(error.localizedDescription.contains("RepositoryError"))
        }
    }
    
    @Test("빈_상품목록을_받으면_빈_배열을_반환한다")
    func testEmptyProductsReturnsEmptyArray() async throws {
        // Given
        let mockRepository = MockHomeRepository()
        mockRepository.mockProducts = []
        let usecase = HomeUsecaseImpl(repository: mockRepository)
        
        // When
        let products = try await usecase.execute()
        
        // Then
        #expect(mockRepository.fetchCallCount == 1)
        #expect(products.isEmpty)
    }
}