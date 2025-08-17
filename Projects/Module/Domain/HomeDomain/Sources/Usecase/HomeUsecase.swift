//
//  File.swift
//  HomeDomain
//
//  Created by linsaeng on 8/16/25.
//

import Foundation

/// 홈 화면 관련 비즈니스 로직을 정의하는 유스케이스 프로토콜입니다.
///
/// HomeUsecase는 Clean Architecture의 Domain 계층에서 비즈니스 규칙을 정의하며,
/// 상품 목록 조회와 특정 상품 조회 기능을 제공합니다.
///
/// - Example:
/// ```swift
/// let usecase: HomeUsecase = HomeUsecaseImpl(repository: repository)
///
/// // 상품 목록 조회
/// let products = try await usecase.execute()
///
/// // 특정 상품 조회
/// let product = try await usecase.execute(with: selectedProduct)
/// ```
public protocol HomeUsecase: Sendable {
    /// 상품 목록을 조회합니다.
    ///
    /// - Returns: 상품 배열
    /// - Throws: 네트워크 오류, 파싱 오류 등의 비즈니스 예외
    func execute() async throws -> [Product]
    
    /// 특정 상품의 상세 정보를 조회합니다.
    ///
    /// - Parameter product: 조회할 상품 객체
    /// - Returns: 상세 정보가 포함된 상품 객체
    /// - Throws: 상품을 찾을 수 없거나 네트워크 오류 등의 예외
    func execute(with product: Product) async throws -> Product
}

/// HomeUsecase 프로토콜의 구현체입니다.
///
/// HomeUsecaseImpl은 Repository 패턴을 통해 데이터 계층과 연결되며,
/// 비즈니스 로직을 캡슐화하여 Presentation 계층에 제공합니다.
///
/// - Example:
/// ```swift
/// let repository = HomeRepositoryImpl(dataSource: dataSource)
/// let usecase = HomeUsecaseImpl(repository: repository)
///
/// // DI 컨테이너에서 사용
/// container.register(HomeUsecase.self) { resolver in
///     let repository = resolver.resolve(HomeRepository.self)!
///     return HomeUsecaseImpl(repository: repository)
/// }
/// ```
public struct HomeUsecaseImpl: HomeUsecase {
    
    private let repository: any HomeRepository
    
    /// HomeUsecaseImpl을 초기화합니다.
    ///
    /// - Parameter repository: 데이터 접근을 위한 Repository 인스턴스
    ///
    /// - Example:
    /// ```swift
    /// let usecase = HomeUsecaseImpl(repository: homeRepository)
    /// ```
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
