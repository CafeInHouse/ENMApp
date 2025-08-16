//
//  ProductTests.swift
//  HomeDomainTests
//
//  Created by linsaeng on 8/17/25.
//

import Testing
import Foundation
@testable import HomeDomain

@Suite("Product")
struct ProductTests {
    
    @Test("Product를_생성하면_모든_프로퍼티가_올바르게_설정된다")
    func testProductInitializationSetsAllProperties() {
        // Given & When
        let product = Product(
            id: "test-id",
            name: "테스트 상품",
            brand: "테스트 브랜드",
            price: 20000,
            discountPrice: 15000,
            discountRate: 25,
            image: "test-image.jpg",
            link: "https://test.com/product",
            tags: ["태그1", "태그2", "태그3"],
            benefits: ["혜택1", "혜택2"],
            rating: 4.7,
            reviewCount: 250
        )
        
        // Then
        #expect(product.id == "test-id")
        #expect(product.name == "테스트 상품")
        #expect(product.brand == "테스트 브랜드")
        #expect(product.price == 20000)
        #expect(product.discountPrice == 15000)
        #expect(product.discountRate == 25)
        #expect(product.image == "test-image.jpg")
        #expect(product.link == "https://test.com/product")
        #expect(product.tags.count == 3)
        #expect(product.tags.contains("태그1"))
        #expect(product.benefits.count == 2)
        #expect(product.benefits.contains("혜택1"))
        #expect(product.rating == 4.7)
        #expect(product.reviewCount == 250)
    }
    
    @Test("동일한_내용의_Product는_같다고_판단한다")
    func testEqualProductsAreEqual() {
        // Given
        let product1 = Product(
            id: "same-id",
            name: "동일상품",
            brand: "동일브랜드",
            price: 10000,
            discountPrice: 8000,
            discountRate: 20,
            image: "same.jpg",
            link: "https://same.com",
            tags: ["tag1"],
            benefits: ["benefit1"],
            rating: 4.0,
            reviewCount: 100
        )
        
        let product2 = Product(
            id: "same-id",
            name: "동일상품",
            brand: "동일브랜드",
            price: 10000,
            discountPrice: 8000,
            discountRate: 20,
            image: "same.jpg",
            link: "https://same.com",
            tags: ["tag1"],
            benefits: ["benefit1"],
            rating: 4.0,
            reviewCount: 100
        )
        
        // When & Then
        #expect(product1 == product2)
        #expect(product1.hashValue == product2.hashValue)
    }
    
    @Test("다른_ID를_가진_Product는_Hashable에서_다르다고_판단한다")
    func testDifferentProductsAreNotEqual() {
        // Given
        let product1 = Product(
            id: "id-1",
            name: "상품",
            brand: "브랜드",
            price: 10000,
            discountPrice: 8000,
            discountRate: 20,
            image: "image.jpg",
            link: "https://link.com",
            tags: ["tag"],
            benefits: ["benefit"],
            rating: 4.0,
            reviewCount: 100
        )
        
        let product2 = Product(
            id: "id-2",
            name: "상품",
            brand: "브랜드",
            price: 10000,
            discountPrice: 8000,
            discountRate: 20,
            image: "image.jpg",
            link: "https://link.com",
            tags: ["tag"],
            benefits: ["benefit"],
            rating: 4.0,
            reviewCount: 100
        )
        
        // When & Then
        #expect(product1.id != product2.id)
        #expect(product1.hashValue != product2.hashValue)
    }
}