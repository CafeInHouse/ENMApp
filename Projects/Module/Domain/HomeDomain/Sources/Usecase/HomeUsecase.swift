//
//  File.swift
//  HomeDomain
//
//  Created by linsaeng on 8/16/25.
//

import Foundation

public protocol HomeUsecase: Sendable {
    func execute() async throws -> [Product]
    func execute(with product: Product) async throws -> Product
}

public struct HomeUsecaseImpl: HomeUsecase {
    
    private let repository: any HomeRepository
    
    public init(repository: any HomeRepository) {
        self.repository = repository
    }
    
    public func execute() async throws -> [Product] {
        return try await repository.fetch()
    }
    
    public func execute(with product: Product) async throws -> Product {
        return try await repository.fetchProduct(id: product.id)
    }
}
