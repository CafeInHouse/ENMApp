//
//  MockHomeDetailUsecase.swift
//  HomeDetailFeatureTests
//
//  Created by linsaeng on 8/17/25.
//

import Foundation
import HomeDomain

class MockHomeDetailUsecase: HomeUsecase {
    var executeCallCount = 0
    var executeWithProductCallCount = 0
    var shouldThrowError = false
    var mockProduct: Product?
    
    func execute() async throws -> [Product] {
        executeCallCount += 1
        
        if shouldThrowError {
            throw NSError(domain: "TestError", code: 1, userInfo: nil)
        }
        
        return mockProduct.map { [$0] } ?? []
    }
    
    func execute(with product: Product) async throws -> Product {
        executeWithProductCallCount += 1
        
        if shouldThrowError {
            throw NSError(domain: "TestError", code: 1, userInfo: nil)
        }
        
        return mockProduct ?? product
    }
}