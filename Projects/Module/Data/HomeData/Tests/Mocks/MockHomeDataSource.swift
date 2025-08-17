//
//  MockHomeDataSource.swift
//  HomeDataTests
//
//  Created by linsaeng on 8/17/25.
//

import Foundation
@testable import HomeData
import HomeDomain

class MockHomeDataSource: HomeDataSource {
    var fetchCallCount = 0
    var fetchWithIdCallCount = 0
    var shouldThrowError = false
    var mockProducts: [Product] = []
    var mockProduct: Product?
    
    func fetch() async throws -> [Product] {
        fetchCallCount += 1
        
        if shouldThrowError {
            throw NSError(domain: "DataSourceError", code: 1, userInfo: nil)
        }
        
        return mockProducts
    }
    
    func fetch(id: String) async throws -> Product {
        fetchWithIdCallCount += 1
        
        if shouldThrowError {
            throw NSError(domain: "DataSourceError", code: 1, userInfo: nil)
        }
        
        if let product = mockProduct {
            return product
        }
        
        // 기본 상품 반환
        return Product(
            id: id,
            name: "Mock Product",
            brand: "Mock Brand",
            price: 10000,
            discountPrice: 8000,
            discountRate: 20,
            image: "mock.jpg",
            link: "https://mock.com",
            tags: ["mock"],
            benefits: ["mock benefit"],
            rating: 4.0,
            reviewCount: 10
        )
    }
}
