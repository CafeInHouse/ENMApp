//
//  HomeDataSourceTests.swift
//  HomeDataTests
//
//  Created by linsaeng on 8/17/25.
//

import Testing
import Foundation
@testable import HomeData
import HomeDomain

@Suite("HomeDataSource")
struct HomeDataSourceTests {
    
    @Test("Provider에서_상품목록을_가져오면_DataSource도_동일한_목록을_반환한다")
    func testFetchReturnsProductsFromProvider() async throws {
        // Given
        let mockProvider = MockHomeProvider()
        let mockProducts = [
            Product(
                id: "ds-1",
                name: "DataSource 상품 1",
                brand: "DS 브랜드",
                price: 30000,
                discountPrice: 25000,
                discountRate: 17,
                image: "ds1.jpg",
                link: "https://ds1.com",
                tags: ["datasource", "test"],
                benefits: ["ds benefit"],
                rating: 4.2,
                reviewCount: 80
            ),
            Product(
                id: "ds-2",
                name: "DataSource 상품 2",
                brand: "DS 브랜드",
                price: 40000,
                discountPrice: 30000,
                discountRate: 25,
                image: "ds2.jpg",
                link: "https://ds2.com",
                tags: ["datasource", "premium"],
                benefits: ["premium service"],
                rating: 4.9,
                reviewCount: 320
            )
        ]
        mockProvider.mockResponse = mockProducts
        let dataSource = HomeDataSourceImpl(provider: mockProvider)
        
        // When
        let products = try await dataSource.fetch()
        
        // Then
        #expect(mockProvider.requestCallCount == 1)
        #expect(products.count == 2)
        #expect(products[0].id == "ds-1")
        #expect(products[1].id == "ds-2")
    }
    
    @Test("특정ID로_상품을_요청하면_해당_상품을_반환한다")
    func testFetchProductByIdReturnsSpecificProduct() async throws {
        // Given
        let mockProvider = MockHomeProvider()
        let mockProducts = [
            Product(
                id: "target-id",
                name: "타겟 상품",
                brand: "타겟 브랜드",
                price: 50000,
                discountPrice: 40000,
                discountRate: 20,
                image: "target.jpg",
                link: "https://target.com",
                tags: ["target"],
                benefits: ["special"],
                rating: 5.0,
                reviewCount: 500
            ),
            Product(
                id: "other-id",
                name: "다른 상품",
                brand: "다른 브랜드",
                price: 10000,
                discountPrice: 8000,
                discountRate: 20,
                image: "other.jpg",
                link: "https://other.com",
                tags: ["other"],
                benefits: ["normal"],
                rating: 3.5,
                reviewCount: 50
            )
        ]
        mockProvider.mockResponse = mockProducts
        let dataSource = HomeDataSourceImpl(provider: mockProvider)
        
        // When
        let product = try await dataSource.fetch(id: "target-id")
        
        // Then
        #expect(mockProvider.requestCallCount == 1) // fetch() 호출로 목록 가져옴
        #expect(product.id == "target-id")
        #expect(product.name == "타겟 상품")
        #expect(product.rating == 5.0)
    }
    
    @Test("Provider에서_에러가_발생하면_DataSource도_에러를_전파한다")
    func testErrorPropagationFromProvider() async throws {
        // Given
        let mockProvider = MockHomeProvider()
        mockProvider.shouldThrowError = true
        let dataSource = HomeDataSourceImpl(provider: mockProvider)
        
        // When & Then
        do {
            _ = try await dataSource.fetch()
            #expect(Bool(false), "에러가 발생해야 합니다")
        } catch {
            #expect(mockProvider.requestCallCount == 1)
            #expect(error is HomeProviderError)
        }
    }
    
    @Test("존재하지_않는_ID로_상품을_요청하면_첫번째_상품을_반환한다")
    func testFetchNonExistentIdReturnFirstProduct() async throws {
        // Given
        let mockProvider = MockHomeProvider()
        let mockProducts = [
            Product(
                id: "first-id",
                name: "첫번째 상품",
                brand: "첫번째 브랜드",
                price: 10000,
                discountPrice: 8000,
                discountRate: 20,
                image: "first.jpg",
                link: "https://first.com",
                tags: ["first"],
                benefits: ["default"],
                rating: 4.0,
                reviewCount: 100
            )
        ]
        mockProvider.mockResponse = mockProducts
        let dataSource = HomeDataSourceImpl(provider: mockProvider)
        
        // When
        let product = try await dataSource.fetch(id: "non-existent-id")
        
        // Then
        #expect(product.id == "first-id")
        #expect(product.name == "첫번째 상품")
    }
}