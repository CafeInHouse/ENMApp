//
//  HomeRepositoryImpl.swift
//  HomeData
//
//  Created by linsaeng on 8/16/25.
//

import Foundation

import HomeDomain

/// HomeRepository 프로토콜의 Data 계층 구현체입니다.
///
/// HomeRepositoryImpl은 Clean Architecture의 Data 계층에서 Domain 계층의
/// Repository 인터페이스를 구현합니다. DataSource와 연결되어 실제 데이터 접근을
/// 담당하며, 도메인 로직과 데이터 접근 로직을 분리합니다.
///
/// - Example:
/// ```swift
/// // Repository 구성
/// let provider = HomeProviderImpl()
/// let dataSource = HomeDataSourceImpl(provider: provider)
/// let repository = HomeRepositoryImpl(dataSource: dataSource)
///
/// // UseCase에서 사용
/// let usecase = HomeUsecaseImpl(repository: repository)
///
/// // DI 컨테이너에서 등록
/// container.register(HomeRepository.self) { resolver in
///     let dataSource = resolver.resolve(HomeDataSource.self)!
///     return HomeRepositoryImpl(dataSource: dataSource)
/// }
/// ```
///
/// - Note: Repository 패턴을 통해 Domain과 Data 계층을 분리하여 테스트 가능성과 유연성을 제공합니다.
public struct HomeRepositoryImpl: HomeRepository {
    
    private let dataSource: any HomeDataSource
    
    /// HomeRepositoryImpl을 초기화합니다.
    ///
    /// - Parameter dataSource: 데이터 소스 접근을 담당하는 DataSource 인스턴스
    ///
    /// - Example:
    /// ```swift
    /// let dataSource = HomeDataSourceImpl(provider: provider)
    /// let repository = HomeRepositoryImpl(dataSource: dataSource)
    /// ```
    public init(dataSource: any HomeDataSource) {
        self.dataSource = dataSource
    }
    
    public func fetch() async throws -> [Product] {
        return try await dataSource.fetch()
    }
    
    public func fetchProduct(id: String) async throws -> Product {
        return try await dataSource.fetch(id: id)
    }
}
