//
//  HomeDetailRequestDTO.swift
//  HomeDomain
//
//  Created by linsaeng on 8/16/25.
//

import Foundation

/// 상품 상세 정보 요청을 위한 DTO(Data Transfer Object)입니다.
///
/// HomeDetailRequestDTO는 특정 상품의 상세 정보 조회 API 호출 시 사용되는 요청 파라미터를 정의합니다.
/// 상품 ID를 통해 해당 상품의 상세 정보를 요청합니다.
///
/// - Example:
/// ```swift
/// // 특정 상품 상세 정보 요청
/// let request = HomeDetailRequestDTO(id: "product_12345")
///
/// // API 호출에서 사용
/// let endpoint = HomeEndPoint.detail(request: request)
/// let product = try await provider.request(endpoint)
/// ```
public struct HomeDetailRequestDTO: Codable, Sendable, Hashable {
    /// 조회할 상품의 고유 식별자
    public let id: String
    
    /// HomeDetailRequestDTO를 초기화합니다.
    ///
    /// - Parameter id: 조회할 상품의 고유 식별자
    ///
    /// - Example:
    /// ```swift
    /// let request = HomeDetailRequestDTO(id: "product_abc123")
    /// ```
    public init(id: String) {
        self.id = id
    }
}
