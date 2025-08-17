//
//  DI.swift
//  Shared
//
//  Created by linsaeng on 8/16/25.
//

import Foundation

import Swinject

/// 전역 의존성 주입 컨테이너를 관리하는 유틸리티입니다.
///
/// DI는 Swinject 프레임워크를 기반으로 한 의존성 주입 시스템의 진입점입니다.
/// 앱 전체에서 사용되는 의존성들을 중앙집중식으로 관리하며,
/// Assembly 패턴을 통해 모듈별 의존성 등록을 지원합니다.
///
/// - Example:
/// ```swift
/// // Assembly 등록
/// DI.register(assemblies: [
///     HomeAssembly(),
///     ENMUIAssembly(),
/// ])
///
/// // 의존성 해결
/// let usecase = DI.container.resolve(HomeUsecase.self)!
/// let repository = DI.container.resolve(HomeRepository.self)!
/// ```
///
/// - Note: Container는 싱글톤으로 관리되며, 앱 시작 시 한 번만 설정하면 됩니다.
public enum DI: Sendable {

    /// 전역 Swinject 컨테이너 인스턴스
    ///
    /// 앱 전체에서 사용되는 단일 컨테이너로, 모든 의존성이 여기에 등록됩니다.
    public static let container = Container()

    /// Assembly 배열을 받아 컨테이너에 의존성을 등록합니다.
    ///
    /// - Parameter assemblies: 등록할 Assembly 객체들의 배열
    ///
    /// - Example:
    /// ```swift
    /// // 앱 시작 시 의존성 등록
    /// DI.register(assemblies: [
    ///     HomeAssembly(),
    ///     ENMUIAssembly(),
    /// ])
    /// ```
    ///
    /// - Note: 이 메서드는 보통 앱 시작 시 한 번만 호출됩니다.
    public static func register(assemblies: [Assembly]) {
        assemblies.forEach { $0.assemble(container: container) }
    }
}
