//
//  WebView.swift
//  Spotify-test
//
//  Created by mvitoriapereirac on 11/11/23.
//

import Foundation
import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    
    private func getAccessTokenFromWebView() -> WKWebView? {
        guard let urlRequest = APIService.shared.getAccessTokenURL() else { return nil }
        let webView = WKWebView()
        
        webView.load(urlRequest)
        webView.navigationDelegate = WebViewNavDelegate.shared
        return webView
        
    }
    
    
    func makeUIView(context: Context) -> WKWebView {
        return getAccessTokenFromWebView() ?? WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context)  {
        if !WebViewNavDelegate.shared.tokenString.isEmpty {
            uiView.isHidden = true
        }
    }
}
