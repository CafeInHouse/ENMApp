//
//  Product.swift
//  HomeDomain
//
//  Created by linsaeng on 8/16/25.
//

import Foundation

public struct Product: Codable, Sendable, Hashable, Identifiable {
    
    public let id: String
    public let name: String
    public let brand: String
    public let price: Int
    public let discountPrice: Int
    public let discountRate: Int
    public let image: String
    public let link: String
    public let tags: [String]
    public let benefits: [String]
    public let rating: Double
    public let reviewCount: Int
    
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
