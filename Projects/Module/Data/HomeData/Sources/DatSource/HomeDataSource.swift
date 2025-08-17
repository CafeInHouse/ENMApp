//
//  HomeDataSource.swift
//  HomeData
//
//  Created by linsaeng on 8/16/25.
//

import Foundation

import HomeDomain

/// 홈 화면 데이터 소스 접근을 위한 DataSource 프로토콜입니다.
///
/// HomeDataSource는 Clean Architecture의 Data 계층에서 다양한 데이터 소스
/// (Provider, Local DB, Cache 등)를 추상화하는 인터페이스를 정의합니다.
/// Repository 패턴에서 하위 데이터 접근 계층을 담당합니다.
///
/// - Example:
/// ```swift
/// // Provider를 통한 DataSource 구현
/// let provider = HomeProviderImpl()
/// let dataSource = HomeDataSourceImpl(provider: provider)
///
/// // 상품 목록 조회
/// let products = try await dataSource.fetch()
///
/// // 특정 상품 조회
/// let product = try await dataSource.fetch(id: "product_123")
/// ```
public protocol HomeDataSource: Sendable {
    
    /// 상품 목록을 조회합니다.
    ///
    /// - Returns: 상품 배열
    /// - Throws: 데이터 조회 실패 시 예외
    ///
    /// - Note: Provider 계층을 통해 실제 데이터 소스에서 데이터를 가져옵니다.
    func fetch() async throws -> [Product]
    
    /// 특정 ID의 상품을 조회합니다.
    ///
    /// - Parameter id: 조회할 상품의 고유 식별자
    /// - Returns: 해당 ID의 상품 객체
    /// - Throws: 상품을 찾을 수 없거나 데이터 조회 실패 시 예외
    func fetch(id: String) async throws -> Product
}

/// HomeDataSource 프로토콜의 구현체입니다.
///
/// HomeDataSourceImpl은 Provider 계층과 연결되어 실제 데이터 조회를 수행합니다.
/// 네트워크 API 호출이나 로컬 데이터 접근을 Provider에 위임하고,
/// 결과를 Domain 계층의 형태로 변환하여 반환합니다.
///
/// - Example:
/// ```swift
/// let provider = HomeProviderImpl()
/// let dataSource = HomeDataSourceImpl(provider: provider)
///
/// // DI 컨테이너에서 사용
/// container.register(HomeDataSource.self) { resolver in
///     let provider = resolver.resolve(HomeProvider.self)!
///     return HomeDataSourceImpl(provider: provider)
/// }
/// ```
public struct HomeDataSourceImpl: HomeDataSource {
    
    private let provider: any HomeProvider
    
    /// HomeDataSourceImpl을 초기화합니다.
    ///
    /// - Parameter provider: 데이터 제공을 담당하는 Provider 인스턴스
    ///
    /// - Example:
    /// ```swift
    /// let provider = HomeProviderImpl()
    /// let dataSource = HomeDataSourceImpl(provider: provider)
    /// ```
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
