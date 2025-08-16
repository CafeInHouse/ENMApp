//
//  MockHomeUsecase.swift
//  HomeFeatureTests
//
//  Created by linsaeng on 8/17/25.
//

import Foundation
import HomeDomain

class MockHomeUsecase: HomeUsecase {
    var executeCallCount = 0
    var executeWithProductCallCount = 0
    var shouldThrowError = false
    var mockProducts: [Product] = []
    var mockProduct: Product?
    
    func execute() async throws -> [Product] {
        executeCallCount += 1
        
        if shouldThrowError {
            throw NSError(domain: "TestError", code: 1, userInfo: nil)
        }
        
        return mockProducts
    }
    
    func execute(with product: Product) async throws -> Product {
        executeWithProductCallCount += 1
        
        if shouldThrowError {
            throw NSError(domain: "TestError", code: 1, userInfo: nil)
        }
        
        return mockProduct ?? product
    }
}