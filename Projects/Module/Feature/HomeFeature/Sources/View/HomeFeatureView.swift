//
//  HomeFeatureView.swift
//  HomeFeature
//
//  Created by linsaeng on 8/16/25.
//

import SwiftUI

// 내부 Module
import Shared
import ENMUI
import HomeDomain

// 외부 Module
import Swinject

public struct HomeFeatureView: View {
    
    @StateObject
    private var viewModel: HomeFeatureViewModelImpl
    
    private var onTapped: (Product) -> Void
    
    public init(
        viewModel: HomeFeatureViewModelImpl = DI.container.resolve(HomeFeatureViewModelImpl.self)!,
        onTapped: @escaping @Sendable (Product) -> Void
    ) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.onTapped = onTapped
    }
    
    public var body: some View {
        _bodyView
            .onAppear {
                viewModel.onAppear()
            }
    }
}

private extension HomeFeatureView {
    
    @ViewBuilder
    var _bodyView: some View {
        NavigationView {
            Group {
                switch viewModel.viewState {
                case .loading:
                    loadingView
                    
                case .normal:
                    normalView
                    
                case .error:
                    Text("")
                }
            }
            .navigationTitle("홈")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

private extension HomeFeatureView {
    
    var loadingView: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(0..<5, id: \.self) { _ in
                    SkeletonCardView()
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 8)
        }
    }
    
    var normalView: some View {
        Text("normalView")
    }
}
