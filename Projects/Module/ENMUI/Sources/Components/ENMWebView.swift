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
