//
//  HomeProvider.swift
//  HomeData
//
//  Created by linsaeng on 8/16/25.
//

import Foundation

/// 네트워크 데이터 제공을 위한 Provider 프로토콜입니다.
///
/// HomeProvider는 Clean Architecture의 Data 계층에서 외부 데이터 소스와의
/// 통신을 담당하는 인터페이스를 정의합니다. REST API 호출, Mock 데이터 제공 등
/// 다양한 데이터 소스를 추상화합니다.
///
/// - Example:
/// ```swift
/// // API 호출
/// let provider: HomeProvider = HomeProviderImpl()
/// let endpoint = HomeEndPoint.home(request: HomeRequestDTO())
/// let products: [Product] = try await provider.request(endpoint)
///
/// // Mock 데이터 사용
/// let mockProvider: HomeProvider = MockHomeProvider()
/// let testProducts: [Product] = try await mockProvider.request(endpoint)
/// ```
public protocol HomeProvider: Sendable {
    /// 지정된 엔드포인트로 네트워크 요청을 수행합니다.
    ///
    /// - Parameter endpoint: 요청할 API 엔드포인트 정보
    /// - Returns: 응답 데이터를 지정된 타입으로 디코딩한 결과
    /// - Throws: 네트워크 오류, 디코딩 오류 등의 예외
    ///
    /// - Note: 제네릭 타입 T는 Decodable을 준수해야 하며, 응답 데이터 구조와 일치해야 합니다.
    func request<T: Decodable>(_ endpoint: EndpointType) async throws -> T
}

/// HomeProvider 프로토콜의 구현체입니다.
///
/// HomeProviderImpl은 현재 Mock 데이터를 제공하는 구현체입니다.
/// 실제 운영 환경에서는 URLSession을 사용한 HTTP 통신으로 교체될 수 있습니다.
///
/// - Example:
/// ```swift
/// let provider = HomeProviderImpl()
/// let endpoint = HomeEndPoint.home(request: HomeRequestDTO())
/// 
/// do {
///     let products: [Product] = try await provider.request(endpoint)
///     print("받은 상품 수: \(products.count)")
/// } catch {
///     print("데이터 로딩 실패: \(error)")
/// }
/// ```
///
/// - Note: 현재는 Bundle의 JSON 파일 또는 하드코딩된 Mock 데이터를 반환합니다.
public struct HomeProviderImpl: HomeProvider {
    
    /// HomeProviderImpl을 초기화합니다.
    ///
    /// - Note: 별도의 설정 없이 기본 Mock 데이터 제공 모드로 동작합니다.
    public init() {}
    
    public func request<T: Decodable>(_ endpoint: any EndpointType) async throws -> T {
        guard let data = loadMockData() else {
            throw HomeProviderError.dataLoadingFailed
        }
        
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
    
    private func loadMockData() -> Data? {
        guard let path = Bundle.module.path(forResource: "products", ofType: "json"),
              let data = NSData(contentsOfFile: path) as Data? else {
            return getMockProductsData()
        }
        return data
    }
    
    private func getMockProductsData() -> Data? {
        let mockProducts = [
            [
                "id": "2059389276",
                "name": "더엣지 25SS 썸머 찰랑 텐션데님 2종",
                "brand": "더엣지",
                "price": 79900,
                "discountPrice": 59900,
                "discountRate": 25,
                "image": "https://image.cjonstyle.net/goods_images/20/276/2059389276L.jpg",
                "link": "https://item.cjonstyle.com/item/2059389276?channelCode=30002002",
                "tags": ["방송상품", "내일꼭!오네", "무료배송", "무료반품"],
                "benefits": ["쿠폰20,000원", "무이자3"],
                "rating": 4.7,
                "reviewCount": 641
            ],
            [
                "id": "2058724538",
                "name": "카시아 속초 스위트룸 주중 주말 균일가 2박",
                "brand": "카시아 속초",
                "price": 599000,
                "discountPrice": 599000,
                "discountRate": 0,
                "image": "https://image.cjonstyle.net/goods_images/20/538/2058724538L.jpg",
                "link": "https://item.cjonstyle.com/item/2058724538?channelCode=30002002",
                "tags": ["방송상품"],
                "benefits": [],
                "rating": 3.5,
                "reviewCount": 6
            ],
            [
                "id": "2032962323",
                "name": "최신상 글로우핏 란제리 커버쿠션 더블구성",
                "brand": "누본셀블랑두부",
                "price": 89000,
                "discountPrice": 84000,
                "discountRate": 6,
                "image": "https://image.cjonstyle.net/goods_images/20/323/2032962323L.jpg",
                "link": "https://item.cjonstyle.com/item/2032962323?channelCode=30002002",
                "tags": ["방송상품", "무료배송", "무료반품"],
                "benefits": ["쇼플쿠폰5,000원", "무이자6"],
                "rating": 4.8,
                "reviewCount": 4086
            ]
        ]
        
        return try? JSONSerialization.data(withJSONObject: mockProducts)
    }
}
