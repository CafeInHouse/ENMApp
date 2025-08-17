//
//  HomRequestDTO.swift
//  HomeDomain
//
//  Created by linsaeng on 8/16/25.
//

import Foundation

/// 홈 화면 데이터 요청을 위한 DTO(Data Transfer Object)입니다.
///
/// HomeRequestDTO는 홈 화면의 상품 목록 조회 API 호출 시 사용되는 요청 파라미터를 정의합니다.
/// 현재는 파라미터가 없는 간단한 구조이지만, 향후 필터링, 페이징 등의 기능 확장이 가능합니다.
///
/// - Example:
/// ```swift
/// // 기본 요청
/// let request = HomeRequestDTO()
///
/// // API 호출에서 사용
/// let endpoint = HomeEndPoint.home(request: request)
/// let products = try await provider.request(endpoint)
/// ```
///
/// - Note: 향후 확장 가능한 필드들:
///   - page: 페이지 번호
///   - limit: 페이지 크기
///   - category: 카테고리 필터
///   - sortBy: 정렬 기준
public struct HomeRequestDTO: Codable, Sendable, Hashable {
    /// HomeRequestDTO를 초기화합니다.
    ///
    /// - Note: 현재는 파라미터가 없지만, 향후 확장을 위해 구조체로 정의되어 있습니다.
    public init() {}
}
