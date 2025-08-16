//
//  HomeDetailFeatureView.swift
//  HomeDetailFeature
//
//  Created by Claude on 8/16/25.
//

import SwiftUI
import WebKit

import HomeDomain
import Shared
import ENMUI

import Swinject

public struct HomeDetailFeatureView: View {
    
    @StateObject private var viewModel: HomeDetailFeatureViewModelImpl
    @StateObject private var webViewModel = ENMWebStore()
    
    private let backButtonTapped: () -> Void
    
    public init(
        product: Product,
        backButtonTapped: @escaping @Sendable () -> Void
    ) {
        self._viewModel = StateObject(
            wrappedValue: HomeDetailFeatureViewModelImpl(
                usecase: DI.container.resolve(HomeUsecase.self)!,
                with: product
            )
        )
        self.backButtonTapped = backButtonTapped
    }
    
    public var body: some View {
        _bodyView
            .onAppear {
                viewModel.onAppear()
            }
            .navigationBarBackButtonHidden(true)
            .navigationTitle(viewModel.product.name)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    backButton
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    navigationButtons
                }
            }
    }
}

private extension HomeDetailFeatureView {
    
    var _bodyView: some View {
        ZStack {
            
            ENMWebView(viewModel: webViewModel, url: viewModel.product.link)
                .ignoresSafeArea(.all, edges: .bottom)
            
            if webViewModel.isLoading {
                loadingOverlay
            }
            
            if webViewModel.hasError {
                errorOverlay
            }
        }
    }
    
    // 로딩 오버레이
    var loadingOverlay: some View {
        ZStack {
            Color.black.opacity(0.3)
                .ignoresSafeArea()
            
            VStack(spacing: 16) {
                ProgressView()
                    .scaleEffect(1.5)
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                
                Text("페이지를 불러오는 중...")
                    .foregroundColor(.white)
                    .font(.system(size: 16, weight: .medium))
                
                ProgressView(value: webViewModel.estimatedProgress)
                    .progressViewStyle(LinearProgressViewStyle(tint: .blue))
                    .scaleEffect(x: 1, y: 2, anchor: .center)
                    .frame(width: 200)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.black.opacity(0.8))
            )
        }
    }
    
    // 에러 오버레이
    var errorOverlay: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Image(systemName: "exclamationmark.triangle")
                    .font(.system(size: 50))
                    .foregroundColor(.orange)
                
                Text("페이지를 불러올 수 없습니다")
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text(webViewModel.errorMessage)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                Button("다시 시도") {
                    webViewModel.reload()
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
        }
    }
    
    var backButton: some View {
        Button(action: {
            backButtonTapped()
        }) {
            Image(systemName: "chevron.left")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.primary)
        }
    }
    
    var navigationButtons: some View {
        HStack(spacing: 16) {
            Button(action: {
                webViewModel.goBack()
            }) {
                Image(systemName: "chevron.backward")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(webViewModel.canGoBack ? .primary : .gray)
            }
            .disabled(!webViewModel.canGoBack)
            
            Button(action: {
                webViewModel.goForward()
            }) {
                Image(systemName: "chevron.forward")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(webViewModel.canGoForward ? .primary : .gray)
            }
            .disabled(!webViewModel.canGoForward)
            
            Button(action: {
                webViewModel.reload()
            }) {
                Image(systemName: "arrow.clockwise")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.primary)
            }
        }
    }
}
