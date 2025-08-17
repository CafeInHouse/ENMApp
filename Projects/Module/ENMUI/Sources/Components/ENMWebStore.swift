//
//  ENMWebViewModel.swift
//  ENMUI
//
//  Created by linsaeng on 8/15/25.
//

import Foundation
import SwiftUI
import WebKit

/// ENMWebView의 상태를 관리하는 ViewModel 클래스입니다.
///
/// ENMWebStore는 WKWebView의 상태 정보를 ObservableObject로 래핑하여
/// SwiftUI에서 반응형으로 사용할 수 있도록 합니다.
/// 로딩 상태, 진행률, 네비게이션 정보, 에러 상태 등을 제공합니다.
///
/// - Example:
/// ```swift
/// @StateObject private var webStore = ENMWebStore()
///
/// VStack {
///     if webStore.isLoading {
///         ProgressView("Loading...", value: webStore.estimatedProgress)
///     }
///     
///     ENMWebView(viewModel: webStore, url: "https://example.com")
///     
///     HStack {
///         Button("Back") { webStore.goBack() }
///             .disabled(!webStore.canGoBack)
///         Button("Forward") { webStore.goForward() }
///             .disabled(!webStore.canGoForward)
///     }
/// }
/// ```
public class ENMWebStore: ObservableObject {
    
    /// 웹페이지 로딩 상태
    @Published public var isLoading = false
    /// 에러 발생 여부
    @Published public var hasError = false
    /// 에러 메시지
    @Published public var errorMessage = ""
    /// 뒤로 가기 가능 여부
    @Published public var canGoBack = false
    /// 앞으로 가기 가능 여부
    @Published public var canGoForward = false
    /// 로딩 진행률 (0.0 ~ 1.0)
    @Published public var estimatedProgress: Double = 0.0
    /// 웹페이지 제목
    @Published public var title = ""
    
    /// 연결된 WKWebView 인스턴스 (weak reference)
    public weak var webView: WKWebView?
    
    /// ENMWebStore를 초기화합니다.
    ///
    /// - Note: 모든 상태 값들이 기본값으로 초기화됩니다.
    public init() {}
    
    public func loadURL(_ urlString: String) {
        guard let url = URL(string: urlString) else {
            DispatchQueue.main.async {
                self.hasError = true
                self.errorMessage = "잘못된 URL입니다: \(urlString)"
            }
            return
        }
        
        // 상태 초기화를 메인 큐에서 안전하게 처리
        DispatchQueue.main.async {
            self.hasError = false
            self.errorMessage = ""
        }
        
        let request = URLRequest(url: url)
        webView?.load(request)
    }
    
    public func reload() {
        DispatchQueue.main.async {
            self.hasError = false
            self.errorMessage = ""
        }
        webView?.reload()
    }
    
    public func goBack() {
        webView?.goBack()
    }
    
    public func goForward() {
        webView?.goForward()
    }
    
    public func updateFromWebView(_ webView: WKWebView) {
        DispatchQueue.main.async {
            self.canGoBack = webView.canGoBack
            self.canGoForward = webView.canGoForward
            self.estimatedProgress = webView.estimatedProgress
            self.title = webView.title ?? ""
        }
    }
    
    public func startLoading() {
        DispatchQueue.main.async {
            self.isLoading = true
            self.hasError = false
            self.errorMessage = ""
        }
    }
    
    public func finishLoading() {
        DispatchQueue.main.async {
            self.isLoading = false
        }
    }
    
    public func setError(_ message: String) {
        DispatchQueue.main.async {
            self.isLoading = false
            self.hasError = true
            self.errorMessage = message
        }
    }
}
