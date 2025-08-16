//
//  HomeDataSource.swift
//  HomeData
//
//  Created by linsaeng on 8/16/25.
//

import Foundation

import HomeDomain

public protocol HomeDataSource: Sendable {
    
    func fetch() async throws -> [Product]
    func fetch(id: String) async throws -> Product
}

public struct HomeDataSourceImpl: HomeDataSource {
    
    private let provider: any HomeProvider
    
    public init(provider: any HomeProvider) {
        self.provider = provider
    }
    
    public func fetch() async throws -> [Product] {
        return try await provider.request(
            HomeEndPoint.home(
                request: HomeRequestDTO()
            )
        )
    }
    
    public func fetch(id: String) async throws -> Product {
        // 실제로는 이렇게 씀
//        return try await provider.request(
//            HomeEndPoint.detail(
//                request: HomeDetailRequestDTO(id: id)
//            )
//        )
        
        // mock 값을 가져옴
        let products: [Product] = try await self.fetch()
        
        // id가 같은 product 하나 가져옴
        return products.first(where: { $0.id == id }) ?? products.first!
    }
}
