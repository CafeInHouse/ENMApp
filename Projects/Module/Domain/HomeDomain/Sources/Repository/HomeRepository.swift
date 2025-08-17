//
//  HomeRepository.swift
//  HomeDomain
//
//  Created by linsaeng on 8/16/25.
//

import Foundation

/// 홈 화면 데이터 접근을 위한 Repository 프로토콜입니다.
///
/// HomeRepository는 Clean Architecture의 Domain 계층에서 데이터 접근 계약을 정의합니다.
/// Data 계층의 구현체가 이 프로토콜을 구현하여 실제 데이터 소스(API, 로컬 DB 등)와의
/// 통신을 담당합니다.
///
/// - Example:
/// ```swift
/// // Data 계층에서 구현
/// class HomeRepositoryImpl: HomeRepository {
///     func fetch() async throws -> [Product] {
///         // API 호출 또는 로컬 데이터 조회 로직
///     }
/// }
///
/// // Domain 계층에서 사용
/// class HomeUsecase {
///     private let repository: HomeRepository
///     
///     func getProducts() async throws -> [Product] {
///         return try await repository.fetch()
///     }
/// }
/// ```
public protocol HomeRepository: Sendable {
    /// 상품 목록을 조회합니다.
    ///
    /// - Returns: 상품 배열
    /// - Throws: 데이터 조회 실패 시 예외
    ///
    /// - Note: 실제 구현체에서는 네트워크 요청, 캐싱, 오류 처리 등을 담당합니다.
    func fetch() async throws -> [Product]
    
    /// 특정 ID의 상품을 조회합니다.
    ///
    /// - Parameter id: 조회할 상품의 고유 식별자
    /// - Returns: 해당 ID의 상품 객체
    /// - Throws: 상품을 찾을 수 없거나 데이터 조회 실패 시 예외
    func fetchProduct(id: String) async throws -> Product
}
