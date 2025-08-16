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
}
