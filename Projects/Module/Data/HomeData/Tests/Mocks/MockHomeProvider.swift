//
//  MockHomeProvider.swift
//  HomeDataTests
//
//  Created by linsaeng on 8/17/25.
//

import Foundation
@testable import HomeData
import HomeDomain

class MockHomeProvider: HomeProvider {
    var requestCallCount = 0
    var shouldThrowError = false
    var mockResponse: Any?
    
    func request<T: Decodable>(_ endpoint: EndpointType) async throws -> T {
        requestCallCount += 1
        
        if shouldThrowError {
            throw HomeProviderError.dataLoadingFailed
        }
        
        if let response = mockResponse as? T {
            return response
        }
        
        // 기본 Mock 데이터 반환
        let mockProducts = [
            Product(
                id: "mock-1",
                name: "Mock 상품 1",
                brand: "Mock 브랜드",
                price: 10000,
                discountPrice: 8000,
                discountRate: 20,
                image: "mock1.jpg",
                link: "https://mock1.com",
                tags: ["mock", "test"],
                benefits: ["mock benefit"],
                rating: 4.5,
                reviewCount: 100
            ),
            Product(
                id: "mock-2",
                name: "Mock 상품 2",
                brand: "Mock 브랜드",
                price: 20000,
                discountPrice: 15000,
                discountRate: 25,
                image: "mock2.jpg",
                link: "https://mock2.com",
                tags: ["mock", "sale"],
                benefits: ["big discount"],
                rating: 4.8,
                reviewCount: 250
            )
        ]
        
        if T.self == [Product].self {
            return mockProducts as! T
        } else if T.self == Product.self {
            return mockProducts.first! as! T
        }
        
        throw HomeProviderError.dataLoadingFailed
    }
}