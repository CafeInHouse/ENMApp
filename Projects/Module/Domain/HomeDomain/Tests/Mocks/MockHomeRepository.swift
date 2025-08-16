//
//  MockHomeRepository.swift
//  HomeDomainTests
//
//  Created by linsaeng on 8/17/25.
//

import Foundation
@testable import HomeDomain

final class MockHomeRepository: HomeRepository, @unchecked Sendable {
    var fetchCallCount = 0
    var fetchProductCallCount = 0
    var shouldThrowError = false
    var mockProducts: [Product] = []
    var mockProduct: Product?
    
    func fetch() async throws -> [Product] {
        fetchCallCount += 1
        
        if shouldThrowError {
            throw NSError(domain: "RepositoryError", code: 1, userInfo: nil)
        }
        
        return mockProducts
    }
    
    func fetchProduct(id: String) async throws -> Product {
        fetchProductCallCount += 1
        
        if shouldThrowError {
            throw NSError(domain: "RepositoryError", code: 1, userInfo: nil)
        }
        
        if let product = mockProduct {
            return product
        }
        
        // 기본 상품 반환
        return Product(
            id: id,
            name: "Default Product",
            brand: "Default Brand",
            price: 10000,
            discountPrice: 8000,
            discountRate: 20,
            image: "default.jpg",
            link: "https://default.com",
            tags: ["default"],
            benefits: ["default benefit"],
            rating: 4.0,
            reviewCount: 10
        )
    }
}