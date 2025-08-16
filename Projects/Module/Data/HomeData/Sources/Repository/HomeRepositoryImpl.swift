//
//  HomeRepositoryImpl.swift
//  HomeData
//
//  Created by linsaeng on 8/16/25.
//

import Foundation

import HomeDomain

public struct HomeRepositoryImpl: HomeRepository {
    
    private let dataSource: any HomeDataSource
    
    public init(dataSource: any HomeDataSource) {
        self.dataSource = dataSource
    }
    
    public func fetch() async throws -> [Product] {
        return try await dataSource.fetch()
    }
}
