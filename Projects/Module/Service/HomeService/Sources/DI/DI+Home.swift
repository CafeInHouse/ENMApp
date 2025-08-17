//
//  DI+Home.swift
//  HomeService
//
//  Created by linsaeng on 8/16/25.
//

import Foundation

// 내부 Module
import HomeFeature
import HomeDomain
import HomeData

import HomeDetailFeature

// 외부 Module
import Swinject

/// 홈 서비스 관련 의존성을 등록하는 Swinject Assembly입니다.
///
/// HomeAssembly는 홈 서비스에서 사용되는 모든 의존성을 중앙집중식으로 등록합니다.
/// Clean Architecture의 각 계층(Data, Domain, Feature)별로 의존성을 구성하며,
/// 의존성 주입 그래프를 올바른 순서로 구성합니다.
///
/// - Example:
/// ```swift
/// // DI 컨테이너에 등록
/// DI.register(assemblies: [HomeAssembly()])
///
/// // 사용 시 의존성 해결
/// let coordinator = DI.container.resolve(HomeCoordinator.self)!
/// ```
///
/// - Note: Assembly 등록 순서는 Provider -> DataSource -> Repository -> UseCase -> ViewModel 순입니다.
public struct HomeAsmely: Assembly {
    
    /// HomeAssembly를 초기화합니다.
    public init() {}

    /// 컨테이너에 홈 서비스 관련 의존성을 등록합니다.
    ///
    /// - Parameter container: 의존성을 등록할 Swinject Container
    ///
    /// 등록되는 의존성들:
    /// - HomeProviderImpl: 데이터 제공 계층
    /// - HomeDataSourceImpl: 데이터 소스 계층  
    /// - HomeRepositoryImpl: Repository 계층
    /// - HomeUsecaseImpl: UseCase 계층
    /// - HomeFeatureViewModelImpl: Presentation 계층
    /// - HomeDetailFeatureViewModelImpl: 상세 화면 Presentation 계층
    public func assemble(container: Container) {
        
        
        container.register(HomeProviderImpl.self) { _ in
            HomeProviderImpl()
        }
        
        container.register(HomeDataSource.self) { container in
            guard let provider = container.resolve(HomeProviderImpl.self) else {
                fatalError()
            }
            
            return HomeDataSourceImpl(provider: provider)
        }
        
        container.register(HomeRepository.self) { container in
            guard let dataSource = container.resolve(HomeDataSource.self) else {
                fatalError()
            }
            
            return HomeRepositoryImpl(dataSource: dataSource)
        }
        
        container.register(HomeUsecase.self) { conatiner in
            guard let respository = conatiner.resolve(HomeRepository.self) else {
                fatalError()
            }
            
            return HomeUsecaseImpl(repository: respository)
        }
        
        container.register(HomeFeatureViewModelImpl.self) { container in
            guard let usecase = container.resolve(HomeUsecase.self) else {
                fatalError()
            }
            return HomeFeatureViewModelImpl(usecase: usecase)
        }
    }
}
