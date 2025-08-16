//
//  HomeRepositoryImplTests.swift
//  HomeDataTests
//
//  Created by linsaeng on 8/17/25.
//

import Testing
import Foundation
@testable import HomeData
import HomeDomain

@Suite("HomeRepositoryImpl")
struct HomeRepositoryImplTests {
    
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
            tags: ["tag\(id)"],
            benefits: ["benefit\(id)"],
            rating: 4.5,
            reviewCount: 100 * Int(id)!
        )
    }
    
    @Test("DataSource에서_상품목록을_가져오면_Repository도_동일한_목록을_반환한다")
    func testFetchReturnsProductsFromDataSource() async throws {
        // Given
        let mockDataSource = MockHomeDataSource()
        mockDataSource.mockProducts = [
            createMockProduct(id: "1"),
            createMockProduct(id: "2"),
            createMockProduct(id: "3")
        ]
        let repository = HomeRepositoryImpl(dataSource: mockDataSource)
        
        // When
        let products = try await repository.fetch()
        
        // Then
        #expect(mockDataSource.fetchCallCount == 1)
        #expect(products.count == 3)
        #expect(products[0].id == "1")
        #expect(products[1].id == "2")
        #expect(products[2].id == "3")
    }
    
    @Test("특정ID로_상품을_요청하면_해당_상품을_반환한다")
    func testFetchProductByIdReturnsSpecificProduct() async throws {
        // Given
        let mockDataSource = MockHomeDataSource()
        let expectedProduct = createMockProduct(id: "5")
        mockDataSource.mockProduct = expectedProduct
        let repository = HomeRepositoryImpl(dataSource: mockDataSource)
        
        // When
        let product = try await repository.fetchProduct(id: "5")
        
        // Then
        #expect(mockDataSource.fetchWithIdCallCount == 1)
        #expect(product.id == "5")
        #expect(product.name == "테스트 상품 5")
        #expect(product.price == 50000)
    }
    
    @Test("DataSource에서_에러가_발생하면_Repository도_에러를_전파한다")
    func testErrorPropagationFromDataSource() async throws {
        // Given
        let mockDataSource = MockHomeDataSource()
        mockDataSource.shouldThrowError = true
        let repository = HomeRepositoryImpl(dataSource: mockDataSource)
        
        // When & Then
        do {
            _ = try await repository.fetch()
            #expect(Bool(false), "에러가 발생해야 합니다")
        } catch {
            #expect(mockDataSource.fetchCallCount == 1)
            #expect(error.localizedDescription.contains("DataSourceError"))
        }
    }
    
    @Test("빈_상품목록을_받으면_빈_배열을_반환한다")
    func testEmptyProductsReturnsEmptyArray() async throws {
        // Given
        let mockDataSource = MockHomeDataSource()
        mockDataSource.mockProducts = []
        let repository = HomeRepositoryImpl(dataSource: mockDataSource)
        
        // When
        let products = try await repository.fetch()
        
        // Then
        #expect(mockDataSource.fetchCallCount == 1)
        #expect(products.isEmpty)
    }
    
    @Test("ID로_상품조회시_에러가_발생하면_에러를_전파한다")
    func testFetchProductByIdErrorPropagation() async throws {
        // Given
        let mockDataSource = MockHomeDataSource()
        mockDataSource.shouldThrowError = true
        let repository = HomeRepositoryImpl(dataSource: mockDataSource)
        
        // When & Then
        do {
            _ = try await repository.fetchProduct(id: "1")
            #expect(Bool(false), "에러가 발생해야 합니다")
        } catch {
            #expect(mockDataSource.fetchWithIdCallCount == 1)
            #expect(error.localizedDescription.contains("DataSourceError"))
        }
    }
}