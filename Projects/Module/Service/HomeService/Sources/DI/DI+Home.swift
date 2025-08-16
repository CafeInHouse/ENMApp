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

// 외부 Module
import Swinject

public struct HomeAsmely: Assembly {
    
    public init() {}

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
