//
//  HomeProviderTests.swift
//  HomeDataTests
//
//  Created by linsaeng on 8/17/25.
//

import Testing
import Foundation
@testable import HomeData
import HomeDomain

@Suite("HomeProvider")
struct HomeProviderTests {
    
    @Test("Mock데이터를_요청하면_Product배열을_반환한다")
    func testRequestReturnsProductArray() async throws {
        // Given
        let provider = HomeProviderImpl()
        let endpoint = HomeEndPoint.home(request: HomeRequestDTO())
        
        // When
        let products: [Product] = try await provider.request(endpoint)
        
        // Then
        #expect(!products.isEmpty)
        #expect(products.count >= 3)
        #expect(products.first?.id == "2059389276")
        #expect(products.first?.name == "더엣지 25SS 썸머 찰랑 텐션데님 2종")
    }
    
    @Test("잘못된_데이터_요청시_에러를_던진다")
    func testInvalidRequestThrowsError() async throws {
        // Given
        let provider = HomeProviderImpl()
        let endpoint = HomeEndPoint.home(request: HomeRequestDTO())
        
        // When & Then
        do {
            // String 타입으로 요청하면 디코딩 에러가 발생해야 함
            let _: String = try await provider.request(endpoint)
            #expect(Bool(false), "에러가 발생해야 합니다")
        } catch {
            #expect(error is DecodingError)
        }
    }
    
    @Test("상세_요청_엔드포인트가_올바르게_생성된다")
    func testDetailEndpointCreation() {
        // Given
        let request = HomeDetailRequestDTO(id: "test-id")
        let endpoint = HomeEndPoint.detail(request: request)
        
        // When & Then
        #expect(endpoint.path == "test-id")
        #expect(endpoint.method == "GET")
        #expect(endpoint.baseURL.isEmpty)
    }
    
    @Test("홈_요청_엔드포인트가_올바르게_생성된다")
    func testHomeEndpointCreation() {
        // Given
        let request = HomeRequestDTO()
        let endpoint = HomeEndPoint.home(request: request)
        
        // When & Then
        #expect(endpoint.path == "/home")
        #expect(endpoint.method == "GET")
        #expect(endpoint.baseURL.isEmpty)
    }
}