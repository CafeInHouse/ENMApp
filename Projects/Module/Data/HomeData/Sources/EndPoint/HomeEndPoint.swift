//
//  HomeEndPoint.swift
//  HomeData
//
//  Created by linsaeng on 8/16/25.
//

import Foundation

import HomeDomain

/// API 엔드포인트 정보를 정의하는 프로토콜입니다.
///
/// EndpointType은 HTTP 요청에 필요한 모든 정보를 제공하는 인터페이스로,
/// 네트워크 Provider에서 실제 요청을 구성할 때 사용됩니다.
///
/// - Example:
/// ```swift
/// struct CustomEndpoint: EndpointType {
///     var baseURL: String { "https://api.example.com" }
///     var path: String { "/users" }
///     var method: String { "GET" }
///     var encodable: Encodable? { nil }
///     var headers: [String: Any] { ["Content-Type": "application/json"] }
/// }
/// ```
public protocol EndpointType: Sendable {
    /// API의 기본 URL
    var baseURL: String { get }
    /// API 경로
    var path: String { get }
    /// HTTP 메서드 (GET, POST 등)
    var method: String { get }
    /// 요청 본문에 포함될 인코딩 가능한 객체
    var encodable: Encodable? { get }
    /// HTTP 헤더 정보
    var headers: [String: Any] { get }
}

/// 홈 화면 관련 API 엔드포인트를 정의하는 열거형입니다.
///
/// HomeEndPoint는 홈 화면에서 사용되는 모든 API 엔드포인트를 타입 안전하게 정의합니다.
/// 각 케이스는 특정 API 호출에 필요한 요청 정보를 포함합니다.
///
/// - Example:
/// ```swift
/// // 홈 화면 상품 목록 조회
/// let homeEndpoint = HomeEndPoint.home(request: HomeRequestDTO())
/// let products: [Product] = try await provider.request(homeEndpoint)
///
/// // 상품 상세 정보 조회
/// let detailEndpoint = HomeEndPoint.detail(request: HomeDetailRequestDTO(id: "123"))
/// let product: Product = try await provider.request(detailEndpoint)
/// ```
public enum HomeEndPoint: EndpointType {
    /// 홈 화면 상품 목록 조회 엔드포인트
    case home(request: HomeRequestDTO)
    /// 상품 상세 정보 조회 엔드포인트
    case detail(request: HomeDetailRequestDTO)
    

    public var baseURL: String {
        return ""
    }

    public var path: String {
        switch self {
        case .home:
            return "/home"
        case .detail(let request):
            return "\(request.id)"

        }
    }

    public var method: String {
        switch self {
        case .home:
            return "GET"

        case .detail:
            return "GET"

        }
    }

    public var encodable: (any Encodable)? {
        switch self {
        case .home(let request):
            return request

        case .detail(let request):
            return request
        }
    }

    public var headers: [String: Any] {
        return [:]
    }
    
}
