//
//  ENMWebViewModel.swift
//  ENMUI
//
//  Created by linsaeng on 8/15/25.
//

import Foundation
import SwiftUI
import WebKit

public class ENMWebStore: ObservableObject {
    
    @Published public var isLoading = false
    @Published public var hasError = false
    @Published public var errorMessage = ""
    @Published public var canGoBack = false
    @Published public var canGoForward = false
    @Published public var estimatedProgress: Double = 0.0
    @Published public var title = ""
    
    public weak var webView: WKWebView?
    
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
