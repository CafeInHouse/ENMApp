//
//  HomeCoordinatorTests.swift
//  HomeServiceTests
//
//  Created by linsaeng on 8/17/25.
//

import Testing
import SwiftUI
@testable import HomeService
import HomeDomain

@Suite("HomeCoordinator")
struct HomeCoordinatorTests {
    
    @Test("초기상태가_로딩일때_onAppear를호출하면_normal상태가된다")
    func testOnAppearChangesStateToNormal() async throws {
        // Given
        let coordinator = HomeCoordinator()
        #expect(coordinator.viewState == .loading)
        
        // When
        coordinator.onAppear()
        
        // Then
        #expect(coordinator.viewState == .normal)
    }
    
    @Test("빈경로상태에서_navigate를호출하면_경로에추가된다")
    func testNavigateAddsRouteToPath() async throws {
        // Given
        let coordinator = HomeCoordinator()
        let product = Product(
            id: "1",
            name: "테스트 상품",
            brand: "테스트 브랜드",
            price: 10000,
            discountPrice: 8000,
            discountRate: 20,
            image: "test.jpg",
            link: "https://test.com",
            tags: ["tag1"],
            benefits: ["benefit1"],
            rating: 4.5,
            reviewCount: 100
        )
        
        // When
        coordinator.navigate(to: .detail(product))
        
        // Then
        #expect(!coordinator.path.isEmpty)
    }
    
    @Test("경로에아이템이있을때_goBack을호출하면_마지막아이템이제거된다")
    func testGoBackRemovesLastItem() async throws {
        // Given
        let coordinator = HomeCoordinator()
        let product = Product(
            id: "1",
            name: "테스트 상품",
            brand: "테스트 브랜드",
            price: 10000,
            discountPrice: 8000,
            discountRate: 20,
            image: "test.jpg",
            link: "https://test.com",
            tags: ["tag1"],
            benefits: ["benefit1"],
            rating: 4.5,
            reviewCount: 100
        )
        coordinator.navigate(to: .detail(product))
        #expect(!coordinator.path.isEmpty)
        
        // When
        coordinator.goBack()
        
        // Then
        #expect(coordinator.path.isEmpty)
    }
    
    @Test("빈경로상태에서_goBack을호출하면_아무변화가없다")
    func testGoBackOnEmptyPathDoesNothing() async throws {
        // Given
        let coordinator = HomeCoordinator()
        #expect(coordinator.path.isEmpty)
        
        // When
        coordinator.goBack()
        
        // Then
        #expect(coordinator.path.isEmpty)
    }
    
    @Test("여러경로가있을때_popToRoot를호출하면_경로가초기화된다")
    func testPopToRootClearsPath() async throws {
        // Given
        let coordinator = HomeCoordinator()
        let product1 = Product(
            id: "1",
            name: "테스트 상품1",
            brand: "테스트 브랜드",
            price: 10000,
            discountPrice: 8000,
            discountRate: 20,
            image: "test1.jpg",
            link: "https://test1.com",
            tags: ["tag1"],
            benefits: ["benefit1"],
            rating: 4.5,
            reviewCount: 100
        )
        let product2 = Product(
            id: "2",
            name: "테스트 상품2",
            brand: "테스트 브랜드",
            price: 20000,
            discountPrice: 15000,
            discountRate: 25,
            image: "test2.jpg",
            link: "https://test2.com",
            tags: ["tag2"],
            benefits: ["benefit2"],
            rating: 4.0,
            reviewCount: 50
        )
        
        coordinator.navigate(to: .detail(product1))
        coordinator.navigate(to: .detail(product2))
        #expect(!coordinator.path.isEmpty)
        
        // When
        coordinator.popToRoot()
        
        // Then
        #expect(coordinator.path.isEmpty)
    }
}