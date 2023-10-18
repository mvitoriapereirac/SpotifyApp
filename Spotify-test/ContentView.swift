//
//  ContentView.swift
//  Spotify-test
//
//  Created by mvitoriapereirac on 28/09/23.
//

import SwiftUI
import WebKit

struct ContentView: View {
    
    private func getAccessTokenFromWebView() -> WKWebView? {
        guard let urlRequest = APIService.shared.getAccessTokenURL() else { return nil }
        let webView = WKWebView()
        
        webView.load(urlRequest)
        return webView
        
    }
    
    var body: some View {
        VStack {
//            Image(systemName: "globe")
//                .imageScale(.large)
//                .foregroundColor(.accentColor)
//            Text("Hello, world!")
            WebView()
                .ignoresSafeArea(.all)
                
        }
//        .padding()
    }
}

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
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
    }
}

class WebViewNavDelegate: NSObject, WKNavigationDelegate {
    static let shared = WebViewNavDelegate()
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        guard let urlString = webView.url?.absoluteString else { return }
        print(urlString)
        
        if urlString.contains("#access_token=") {
            let range = urlString.range(of:"#access_token=")
            guard let index = range?.upperBound else { return }
            print(urlString[index...])
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
 
