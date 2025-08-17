//
//  Product.swift
//  HomeDomain
//
//  Created by linsaeng on 8/16/25.
//

import Foundation

/// 상품 정보를 나타내는 도메인 엔티티입니다.
///
/// Product는 전자상거래 앱에서 사용되는 상품의 모든 정보를 담고 있는 핵심 도메인 모델입니다.
/// 가격, 할인 정보, 리뷰, 태그 등 상품과 관련된 모든 데이터를 포함합니다.
///
/// - Example:
/// ```swift
/// let product = Product(
///     id: "12345",
///     name: "iPhone 15 Pro",
///     brand: "Apple",
///     price: 1490000,
///     discountPrice: 1350000,
///     discountRate: 10,
///     image: "https://example.com/iphone.jpg",
///     link: "https://store.apple.com/iphone-15-pro",
///     tags: ["스마트폰", "프리미엄"],
///     benefits: ["무료배송", "AppleCare+"],
///     rating: 4.8,
///     reviewCount: 2341
/// )
/// ```
///
/// - Note: 모든 프로퍼티는 불변(immutable)이며, JSON 직렬화를 지원합니다.
public struct Product: Codable, Sendable, Hashable, Identifiable {
    
    /// 상품의 고유 식별자
    public let id: String
    /// 상품명
    public let name: String
    /// 브랜드명
    public let brand: String
    /// 정가 (원 단위)
    public let price: Int
    /// 할인가 (원 단위)
    public let discountPrice: Int
    /// 할인율 (퍼센트)
    public let discountRate: Int
    /// 상품 이미지 URL
    public let image: String
    /// 상품 상세 페이지 링크
    public let link: String
    /// 상품 태그 배열
    public let tags: [String]
    /// 혜택 정보 배열 (무료배송, 쿠폰 등)
    public let benefits: [String]
    /// 평점 (0.0 ~ 5.0)
    public let rating: Double
    /// 리뷰 개수
    public let reviewCount: Int
    
    /// Product 인스턴스를 초기화합니다.
    ///
    /// - Parameters:
    ///   - id: 상품의 고유 식별자
    ///   - name: 상품명
    ///   - brand: 브랜드명
    ///   - price: 정가 (원 단위)
    ///   - discountPrice: 할인가 (원 단위)
    ///   - discountRate: 할인율 (퍼센트, 0-100)
    ///   - image: 상품 이미지 URL 문자열
    ///   - link: 상품 상세 페이지 링크
    ///   - tags: 상품 태그 배열
    ///   - benefits: 혜택 정보 배열
    ///   - rating: 평점 (0.0-5.0 범위)
    ///   - reviewCount: 리뷰 개수
    ///
    /// - Example:
    /// ```swift
    /// let product = Product(
    ///     id: "prod_001",
    ///     name: "무선 이어폰",
    ///     brand: "TechBrand",
    ///     price: 150000,
    ///     discountPrice: 120000,
    ///     discountRate: 20,
    ///     image: "https://example.com/earbuds.jpg",
    ///     link: "https://shop.example.com/earbuds",
    ///     tags: ["오디오", "무선"],
    ///     benefits: ["무료배송"],
    ///     rating: 4.5,
    ///     reviewCount: 847
    /// )
    /// ```
    public init(
        id: String,
        name: String,
        brand: String,
        price: Int,
        discountPrice: Int,
        discountRate: Int,
        image: String,
        link: String,
        tags: [String],
        benefits: [String],
        rating: Double,
        reviewCount: Int
    ) {
        self.id = id
        self.name = name
        self.brand = brand
        self.price = price
        self.discountPrice = discountPrice
        self.discountRate = discountRate
        self.image = image
        self.link = link
        self.tags = tags
        self.benefits = benefits
        self.rating = rating
        self.reviewCount = reviewCount
    }
}
