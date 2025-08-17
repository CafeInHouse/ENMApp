//
//  HomError.swift
//  HomeData
//
//  Created by linsaeng on 8/16/25.
//

import Foundation

/// HomeProvider에서 발생할 수 있는 오류를 정의하는 열거형입니다.
///
/// HomeProviderError는 데이터 제공 과정에서 발생하는 다양한 오류 상황을
/// 타입 안전하게 표현하여 적절한 오류 처리를 가능하게 합니다.
///
/// - Example:
/// ```swift
/// do {
///     let products: [Product] = try await provider.request(endpoint)
/// } catch HomeProviderError.dataLoadingFailed {
///     print("데이터 로딩에 실패했습니다.")
/// } catch HomeProviderError.decodingFailed {
///     print("JSON 파싱에 실패했습니다.")
/// } catch {
///     print("알 수 없는 오류: \(error)")
/// }
/// ```
public enum HomeProviderError: Error {
    /// 데이터 로딩 실패 (파일 없음, 네트워크 오류 등)
    case dataLoadingFailed
    /// JSON 디코딩 실패 (형식 오류, 타입 불일치 등)
    case decodingFailed
}
