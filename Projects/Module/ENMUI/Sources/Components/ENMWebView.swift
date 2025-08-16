//
//  ENMWebView.swift
//  ENMUI
//
//  Created by linsaeng on 8/15/25.
//

import Foundation
import SwiftUI
import WebKit

public struct ENMWebView: UIViewRepresentable {
    
    @ObservedObject var store: ENMWebStore
    let url: String
    
    public init(viewModel: ENMWebStore, url: String) {
        self.store = viewModel
        self.url = url
    }
    
    public func makeUIView(context: Context) -> WKWebView {
        let configuration = WKWebViewConfiguration()
        
        configuration.allowsInlineMediaPlayback = true
        configuration.mediaTypesRequiringUserActionForPlayback = []
        
        let webView = WKWebView(frame: .zero, configuration: configuration)
        
        webView.navigationDelegate = context.coordinator
        webView.uiDelegate = context.coordinator
        
        webView.addObserver(context.coordinator, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        webView.addObserver(context.coordinator, forKeyPath: #keyPath(WKWebView.title), options: .new, context: nil)
        webView.addObserver(context.coordinator, forKeyPath: #keyPath(WKWebView.canGoBack), options: .new, context: nil)
        webView.addObserver(context.coordinator, forKeyPath: #keyPath(WKWebView.canGoForward), options: .new, context: nil)
        
        store.webView = webView
        
        return webView
    }
    
    public func updateUIView(_ webView: WKWebView, context: Context) {
        if let currentURL = webView.url?.absoluteString, currentURL != url {
            store.loadURL(url)
        } else if webView.url == nil {
            store.loadURL(url)
        }
    }
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(store)
    }
    
    public class Coordinator: NSObject, WKNavigationDelegate, WKUIDelegate {
        
        private let store: ENMWebStore
        
        init(_ store: ENMWebStore) {
            self.store = store
        }

        public override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
            guard let webView = object as? WKWebView else { return }
            
            DispatchQueue.main.async {
                self.store.updateFromWebView(webView)
            }
        }

        public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            store.startLoading()
        }
        
        public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            store.finishLoading()
            store.updateFromWebView(webView)
        }
        
        public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            store.setError("페이지를 불러올 수 없습니다: \(error.localizedDescription)")
        }
        
        public func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
            store.setError("페이지 로드에 실패했습니다: \(error.localizedDescription)")
        }
        
        public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            decisionHandler(.allow)
        }

        public func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
            if navigationAction.targetFrame == nil {
                webView.load(navigationAction.request)
            }
            return nil
        }
        
        public func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
            completionHandler()
        }
        
        deinit {
            store.webView?.removeObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress))
            store.webView?.removeObserver(self, forKeyPath: #keyPath(WKWebView.title))
            store.webView?.removeObserver(self, forKeyPath: #keyPath(WKWebView.canGoBack))
            store.webView?.removeObserver(self, forKeyPath: #keyPath(WKWebView.canGoForward))
        }
    }
}

#if DEBUG
// Preview용 Mock Store
class MockENMWebStore: ENMWebStore {
    
    override init() {
        super.init()
    }
    
    static func loadingState() -> MockENMWebStore {
        let store = MockENMWebStore()
        store.isLoading = true
        store.title = "로딩 중..."
        store.estimatedProgress = 0.5
        return store
    }
    
    static func successState() -> MockENMWebStore {
        let store = MockENMWebStore()
        store.isLoading = false
        store.title = "Apple (대한민국)"
        store.canGoBack = true
        store.canGoForward = false
        store.estimatedProgress = 1.0
        return store
    }
    
    static func errorState() -> MockENMWebStore {
        let store = MockENMWebStore()
        store.isLoading = false
        store.hasError = true
        store.errorMessage = "네트워크 연결을 확인하세요"
        store.title = "오류"
        return store
    }
}

#Preview("WebView Loading") {
    VStack {
        Text("웹뷰 로딩 상태")
            .font(.headline)
            .padding()
        
        ENMWebView(
            viewModel: MockENMWebStore.loadingState(),
            url: "https://www.apple.com/kr/"
        )
        .frame(height: 400)
        .cornerRadius(12)
        .padding()
        
        Text("로딩 중인 웹페이지를 보여줍니다")
            .font(.caption)
            .foregroundColor(.secondary)
    }
    .background(Color(.systemGroupedBackground))
}

#Preview("WebView Success") {
    VStack {
        Text("웹뷰 성공 상태")
            .font(.headline)
            .padding()
        
        ENMWebView(
            viewModel: MockENMWebStore.successState(),
            url: "https://www.apple.com/kr/"
        )
        .frame(height: 400)
        .cornerRadius(12)
        .padding()
        
        Text("정상적으로 로드된 웹페이지를 보여줍니다")
            .font(.caption)
            .foregroundColor(.secondary)
    }
    .background(Color(.systemGroupedBackground))
}

#Preview("WebView Error") {
    VStack {
        Text("웹뷰 에러 상태")
            .font(.headline)
            .padding()
        
        ENMWebView(
            viewModel: MockENMWebStore.errorState(),
            url: "https://invalid-url.example.com"
        )
        .frame(height: 400)
        .cornerRadius(12)
        .padding()
        
        Text("에러가 발생한 웹페이지를 보여줍니다")
            .font(.caption)
            .foregroundColor(.secondary)
    }
    .background(Color(.systemGroupedBackground))
}

#Preview("WebView Usage") {
    NavigationView {
        VStack(spacing: 16) {
            // 웹뷰 컨트롤 버튼들
            HStack(spacing: 16) {
                Button("← 뒤로") { }
                    .disabled(true)
                
                Button("새로고침") { }
                
                Button("앞으로 →") { }
                    .disabled(true)
            }
            .padding()
            
            // 웹뷰
            ENMWebView(
                viewModel: MockENMWebStore.successState(),
                url: "https://www.apple.com/kr/"
            )
            .cornerRadius(12)
            .shadow(radius: 2)
            
            // 진행률 표시
            VStack(alignment: .leading, spacing: 4) {
                Text("로딩 진행률")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                ProgressView(value: 1.0, total: 1.0)
                    .progressViewStyle(LinearProgressViewStyle())
            }
            .padding(.horizontal)
        }
        .padding()
        .navigationTitle("웹뷰 예시")
        .navigationBarTitleDisplayMode(.inline)
    }
    .background(Color(.systemGroupedBackground))
}
#endif
